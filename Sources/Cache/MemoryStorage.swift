//
//  MemoryStorage.swift
//  
//
//  Created by seongho.hong on 2021/10/03.
//

import Foundation

public final class MemoryStorage<Value> where Value: Codable {
        
    private lazy var memoryCache: NSCache<NSString, NSData> = {
        let imageCache = NSCache<NSString, NSData>()
        imageCache.countLimit = countLimit
        return imageCache
    }()
    
    private let countLimit: Int
    
    public init(countLimit: Int) {
        self.countLimit = countLimit
    }
        
    public func value(forKey key: String) -> Value? {
        memoryCache
            .object(forKey: NSString(string: key))
            .flatMap { Data(referencing: $0) }
            .flatMap { try? JSONDecoder().decode(Value.self, from: $0) }
    }
    
    public func save(_ value: Value, forKey key: String) {
        guard let data = try? JSONEncoder().encode(value) else {
            return
        }
        
        memoryCache.setObject(NSData(data: data), forKey: NSString(string: key))
    }

}
