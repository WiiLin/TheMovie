//
//  WLApiPath.swift
//  The Movie
//
// Created by Wii Lin on 2021/6/1.
//

import Alamofire

enum WLApiPath: Equatable {
    case movieList
    case movieDetail

    var path: String {
        switch self {
        case .movieList:
            return "/\(version)/discover/movie"
        case .movieDetail:
            return "/\(version)/movie"
        }
    }

    var version: String {
        return "3"
    }
}
