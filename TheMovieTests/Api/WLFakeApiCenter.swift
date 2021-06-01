//
//  WLFakeApiCenter.swift
//  TheMovieTests
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

@testable import TheMovie
import Foundation

class WLFakeApiCenter: WLRequestProtocol {
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    func discoverMovies(page: UInt, sort: WLMovieListApi.Sort, completionHandler: @escaping (Result<WLMovieListApi.ApiResponse, WLError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            guard let data = Bundle(for: WLFakeApiCenter.self).fileData(resource: "FakeMovieList", type: "json") else {
                completionHandler(.failure(.urlCreateError))
                return
            }
            do {
                let response = try self.jsonDecoder.decode(WLMovieListApi.ApiResponse.self, from: data)
                completionHandler(.success(response))
            } catch {
                completionHandler(.failure(.jsonDecoderDecodeError(error)))
            }
        }
    }
    
    func getMovieDetail(id: Int, completionHandler: @escaping (Result<WLMovieDetailApi.ApiResponse, WLError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            guard let data = Bundle(for: WLFakeApiCenter.self).fileData(resource: "FakeMovieDetail", type: "json") else {
                completionHandler(.failure(.urlCreateError))
                return
            }
            do {
                let response = try self.jsonDecoder.decode(WLMovieDetailApi.ApiResponse.self, from: data)
                completionHandler(.success(response))
            } catch {
                completionHandler(.failure(.jsonDecoderDecodeError(error)))
            }
        }
    }
    
   
}
