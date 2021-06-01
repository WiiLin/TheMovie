//
//  URL+Custom.swift
//  TheMovie
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

import Foundation

extension URL {
    static let apiHost: URL = URL(string: "https://api.themoviedb.org")!
    static let movieImageHost: URL = URL(string: "https://image.tmdb.org")!
    static let bookURLHost: URL = URL(string: "https://www.themoviedb.org")!
    
    static func movieApi(path: String) -> URL? {
        let url = URL.apiHost
        var urlComponents: URLComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.path = path
        return urlComponents.url
    }
    
    static func movieImage(path: String) -> URL? {
        let url = URL.movieImageHost
        var urlComponents: URLComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/t/p/w500" + path
        return urlComponents.url
    }
    
    static func book(id: Int) -> URL? {
        let url = URL.bookURLHost
        var urlComponents: URLComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/movie/" + "\(id)"
        return urlComponents.url
    }
}
