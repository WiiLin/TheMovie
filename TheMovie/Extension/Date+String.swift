//
//  Date+String.swift
//  TheMovie
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

import Foundation

extension Date {
    func string(dateFormat: String) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = dateFormat
        let dateString = dateformatter.string(from: self)
        return dateString
    }
}
