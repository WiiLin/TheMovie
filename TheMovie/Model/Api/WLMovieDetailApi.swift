//
//  WLMovieDetailApi.swift
//  TheMovie
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

import Alamofire

struct WLMovieDetailApi: WLApi, Encodable {
    typealias ApiResponse = WLMovieDetail
    struct Request: Encodable {
        let apiKey: String
    }
    
    var path: String { return "\(WLApiPath.movieDetail.path)/\(id)" }
    var method: HTTPMethod { return .get }
    var headers: HTTPHeaders? { return nil }
    var request: Encodable? { return self }
    
    let id: Int
    let apiKey: String
}

struct WLMovieDetail: Codable {
    struct WLGenre: Codable {
        let name: String
    }
    
    struct WLSpokenLanguage: Codable {
        let name: String
    }
    
    let overview: String?
    let tagline: String?
    let genres: [WLGenre]
    let spokenLanguages: [WLSpokenLanguage]
    let runtime: Int?
    
    var displayGenres: String {
        return genres.map { $0.name }.joined(separator: "、")
    }
    
    var displaySpokenLanguages: String {
        return spokenLanguages.map { $0.name }.joined(separator: "、")
    }
}
