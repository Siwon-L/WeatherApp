//
//  Then.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/15.
//

import Foundation

protocol Then {}

extension Then where Self: AnyObject {
    @inlinable
    @discardableResult
    func then(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

extension NSObject: Then {}
