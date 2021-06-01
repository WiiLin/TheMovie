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
        navigationBar.prefersLargeTitles = true
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.lightGreen!]
        navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.lightGreen!]
        navigationBar.barTintColor = .backgroundBlack
        navigationBar.tintColor = .lightGreen
        navigationBar.isTranslucent = false
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
