//
//  WLMovieListApi.swift
//  TheMovie
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

import Alamofire

struct WLEmpty: Codable {}

struct WLMovieListApi: WLApi, Encodable {
    enum Sort: String, Encodable, CaseIterable {
        case releaseDate = "primary_release_date.desc"
        case popularity = "popularity.desc"
        case voteCount = "vote_count.desc"
        
        var displayName: String {
            switch self {
            case .releaseDate:
                return "release date"
            case .popularity:
                return "popularity"
            case .voteCount:
                return "vote count"
            }
        }
    }
    typealias ApiResponse = Response
    struct Response: Decodable {
        let results: [WLMovie]
    }

    var path: String { return WLApiPath.movieList.path }
    var method: HTTPMethod { return .get }
    var headers: HTTPHeaders? { return nil }
    var encoding: ParameterEncoding { return JSONEncoding.default }
    var request: Encodable? { return self }

    let apiKey: String
    let primaryReleaseDatelte: String
    let sortBy: Sort
    let page: UInt
}

struct WLMovie: Decodable {
    let id: Int
    let title: String
    let popularity: Double
    let backdropPath: String?
    let posterPath: String?
    let releaseDate: String?
    var detail: WLMovieDetail?
}
