//
//  ViewController.swift
//  TheMovie
//
//  Created by Wii Lin on 2021/6/1.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let api: WLApiCenter = WLApiCenter()
        api.discoverMovies(page: 1, sort: .releaseDate) { result in
            switch result {
            case let .success(response):
                api.getMovieDetail(id: response.results.first!.id) { result in
                    
                }
            case let .failure(error):
                print("")
            }
        }
    }


}

