//
//  Storable.swift
//  
//
//  Created by seongho.hong on 2021/10/03.
//

import Foundation

public protocol CacheStorage {
    associatedtype Value
    
    func value(forKey key: String) throws -> Value?
    func save(_ value: Value, forKey key: String) throws
}
