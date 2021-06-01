//
//  WLObservable.swift
//  TheMovie
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

import Foundation

@propertyWrapper
class Observable<T> {
    var projectedValue: Observable<T> { return self }
    var wrappedValue: T {
        get { return value }
        set { value = newValue }
    }
    
    private var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }
    
    private var valueChanged: ((T) -> Void)?
    
    init(wrappedValue: T) {
        value = wrappedValue
    }
    
    func callAsFunction<Object: AnyObject>(bind object: Object, fireNow: Bool = false, _ onChanged: @escaping (Object, T) -> Void) {
        valueChanged = { [weak object] value in
            guard let object = object else { return }
            onChanged(object, value)
        }
        
        if fireNow {
            valueChanged?(value)
        }
    }
    
    func removeObserver() {
        valueChanged = nil
    }
}
