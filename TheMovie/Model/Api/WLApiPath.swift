//
//  WLApiPath.swift
//  TheMovie
//
// Created by Wii Lin on 2021/6/1.
//

import Alamofire

enum WLApiPath: Equatable {
    case movieList
    case movieDetail
    case movieImage
    
    var path: String {
        switch self {
        case .movieList:
            return "/\(version)/discover/movie"
        case .movieDetail:
            return "/\(version)/movie"
        case .movieImage:
            return "/t/p/w500"
        }
    }
    
    var version: String {
        return "3"
    }
}
