//
//  WLApi.swift
//  TheMovie
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

import Alamofire

protocol WLApi {
    associatedtype ApiResponse: Decodable
    var request: Encodable? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
}
