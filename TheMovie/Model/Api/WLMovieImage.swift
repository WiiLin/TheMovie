//
//  WLMovieImage.swift
//  TheMovie
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

import Foundation

struct WLMovieImage {
    var url: URL? {
        var baseURLComponents = WLApiCenter.imageBaseURLComponents
        baseURLComponents.path = path
        return baseURLComponents.url
    }
    
    var path: String { return WLApiPath.movieImage.path + imagePath }
    
    let imagePath: String
}
