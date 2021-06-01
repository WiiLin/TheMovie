//
//  Bundle+Data.swift
//  TheMovie
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

import Foundation

extension Bundle {
    func fileData(resource: String, type: String) -> Data? {
        guard let path = path(forResource: resource, ofType: type) else { return nil }
        do {
            return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        } catch {
            print(error)
            return nil
        }
    }
}
