//
//  WLApiBase.swift
//  TheMovie
//
// Created by Wii Lin on 2021/6/1.
//

import Alamofire
import Foundation

public class WLApiBase: NSObject {
    // MARK: - Properties
    
    let apiKey: String = "328c283cd27bd1877d9080ccb1604c91"
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    static let imageBaseURLComponents: URLComponents = {
        let url = URL(string: "https://image.tmdb.org/")!
        var urlComponents: URLComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        return urlComponents
    }()
    
    private var baseURLComponents: URLComponents = {
        let url = URL(string: "https://api.themoviedb.org/")!
        var urlComponents: URLComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        return urlComponents
    }()
    
    private let sessionManager: Session = {
        let session = Session.default
        session.session.configuration.timeoutIntervalForRequest = 60
        return session
    }()
}

// MARK: - Interface

extension WLApiBase {
    func request<ApiRequest: WLApi, ApiResponse: Decodable>(api: ApiRequest,
                                                            responseType: ApiResponse.Type,
                                                            completionHandler: @escaping (Result<ApiResponse, WLError>) -> Void) {
        baseURLComponents.path = api.path
        guard let url = baseURLComponents.url else {
            completionHandler(.failure(.urlCreateError))
            return
        }
        
        let finalParameters: Parameters? = {
            if let requestType = api.request, let parameters = requestType.parameters, !parameters.isEmpty {
                return parameters
            } else {
                return nil
            }
        }()
        let request: DataRequest = sessionManager.request(url,
                                                          method: api.method,
                                                          parameters: finalParameters,
                                                          encoding: api.method == .get ? URLEncoding.default : JSONEncoding.default,
                                                          headers: api.headers,
                                                          interceptor: self)
        self.request(request: request, method: api.method, parameters: finalParameters) { result in
            switch result {
            case let .success(data):
                if let data = data {
                    do {
                        let response = try self.jsonDecoder.decode(responseType, from: data)
                        completionHandler(.success(response))
                    } catch {
                        print("❌ \(error)")
                        completionHandler(.failure(.jsonDecoderDecodeError(error)))
                    }
                } else if responseType is WLEmpty.Type {
                    completionHandler(.success(WLEmpty() as! ApiResponse))
                } else {
                    completionHandler(.failure(.apiResponseSourceError))
                }
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}

// MARK: - Private Method

private extension WLApiBase {
    func request(request: DataRequest, method: HTTPMethod, parameters: Parameters?, completionHandler: @escaping (Result<Data?, WLError>) -> Void) {
        request
            .validate(statusCode: 200 ..< 400)
            .response { response in
                self.printResponse(response: response, parameters: parameters, method: method)
                switch response.result {
                case let .success(response):
                    completionHandler(.success(response))
                case let .failure(error):
                    if case let .requestRetryFailed(retryError, _) = error.asAFError, retryError is WLError {
                        completionHandler(.failure(retryError as! WLError))
                    } else {
                        let responseError = error as NSError
                        print("\(responseError.localizedDescription)")
                        if let data = response.data {
                            if let jsonDictionary = data.jsonDataDictionary {
                                completionHandler(.failure(WLError.serverError(errorObject: jsonDictionary)))
                            } else {
                                completionHandler(.failure(WLError.nsError(error: responseError)))
                            }
                        } else {
                            completionHandler(.failure(WLError.nsError(error: responseError)))
                        }
                    }
                }
            }
    }
    
    func printResponse(response: AFDataResponse<Data?>, parameters: Parameters?, method: HTTPMethod) {
        print("🤟🏻🤟🏻🤟🏻🤟🏻🤟🏻🤟🏻")
        print("✈️ \(response.request?.url?.absoluteString ?? "")")
        print("⚙️ \(method.rawValue)")
        let allHTTPHeaderFields = response.request?.allHTTPHeaderFields ?? [:]
        print("📇 \(allHTTPHeaderFields)")
        
        let parameters = parameters ?? [:]
        print("🎒 \(parameters)")
        
        let statusCode = response.response?.statusCode ?? -1
        print("🚥 \(statusCode)")
        
        if let data = response.data {
            print("🎁 \(String(decoding: data, as: UTF8.self))")
        }
        print("🤟🏻🤟🏻🤟🏻🤟🏻🤟🏻🤟🏻")
    }
}

// MARK: - RequestInterceptor

extension WLApiBase: RequestInterceptor {
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        completion(.success(urlRequest))
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetryWithError(error))
    }
}

// MARK: - Alamofire+Custom

private extension Encodable {
    var parameters: Parameters? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        guard let data = try? jsonEncoder.encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? Parameters }
    }
}

// MARK: - Data+Dictionary

private extension Data {
    var jsonDataDictionary: [String: Any]? {
        do {
            if let dictionary = try JSONSerialization.jsonObject(with: self, options: .mutableLeaves) as? [String: Any] {
                return dictionary
            } else {
                return nil
            }
        } catch {
            print("error: \(error.localizedDescription)")
            return nil
        }
    }
}
