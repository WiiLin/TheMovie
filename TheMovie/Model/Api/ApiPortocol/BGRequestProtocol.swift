//
//  WLRequestProtocol.swift
//  TheMovie
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

import Foundation

protocol WLRequestProtocol {
    func discoverMovies(page: UInt, sort: WLMovieListApi.Sort, completionHandler: @escaping (Result<WLMovieListApi.ApiResponse, WLError>) -> Void)
    func getMovieDetail(id: Int, completionHandler: @escaping (Result<WLMovieDetailApi.ApiResponse, WLError>) -> Void)
}

