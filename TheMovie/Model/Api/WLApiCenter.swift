//
//  WLApiCenter.swift
//  The Movie
//
// Created by Wii Lin on 2021/6/1.
//

import Foundation

class WLApiCenter: WLApiBase, WLRequestProtocol {

    func discoverMovies(page: UInt,sort: WLMovieListApi.Sort, completionHandler: @escaping (Result<WLMovieListApi.ApiResponse, WLError>) -> Void) {
        let api = WLMovieListApi(apiKey: apiKey,
                                 primaryReleaseDatelte: Date().string(dateFormat: "YYYY-MM-dd"),
                                 sortBy: sort,
                                 page: 1)
        request(api: api,
                responseType: WLMovieListApi.ApiResponse.self,
                completionHandler: completionHandler)
    }
    
    func getMovieDetail(id: Int, completionHandler: @escaping (Result<WLMovieDetailApi.ApiResponse, WLError>) -> Void) {
        let api = WLMovieDetailApi(id: id, apiKey: apiKey)
        request(api: api,
                responseType: WLMovieDetailApi.ApiResponse.self,
                completionHandler: completionHandler)
    }
}


