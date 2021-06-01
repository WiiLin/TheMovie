//
//  WLNavigationController.swift
//  TheMovie
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

import UIKit

class WLNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.lightGreen!]
        navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.lightGreen!]
        navigationBar.barTintColor = .backgroundBlack
        navigationBar.tintColor = .lightGreen
        navigationBar.barStyle = .black
        navigationBar.isTranslucent = true
    }
}
