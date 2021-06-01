//
//  AlertPresentable.swift
//  TheMovie
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

import UIKit

protocol AlertPresentable {
    func presentErrorAlert(message: String, action: ((UIAlertAction) -> Swift.Void)?)
}

extension AlertPresentable where Self: UIViewController {
    func presentErrorAlert(message: String, action: ((UIAlertAction) -> Swift.Void)?) {
        let alert: UIAlertController = UIAlertController(title: "Opps!", message: message, preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: "ok", style: .default, handler: action)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
