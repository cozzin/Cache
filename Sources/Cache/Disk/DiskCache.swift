//
//  DiskCache.swift
//  
//
//  Created by seongho.hong on 2021/10/03.
//

import Foundation

public struct DiskCache<Value>: CacheStorage where Value: Codable {
    
    private let fileManager: DiskCacheFileManagable
    
    init(fileManager: DiskCacheFileManagable = DefaultFileManager()) {
        self.fileManager = fileManager
    }
    
    public func value(forKey key: String) throws -> Value? {
        let filePathURL = try fileManager.filePathURL(forKey: key)
        guard let data = try? fileManager.data(of: filePathURL) else {
            return nil
        }
        
        let value = try JSONDecoder().decode(Value.self, from: data)
        return value
    }
    
    public func save(_ value: Value, forKey key: String) throws {
        let filePathURL = try fileManager.filePathURL(forKey: key)
        try fileManager.assureDirectoryExists(filePathURL: filePathURL)
        
        let data = try JSONEncoder().encode(value)
        try fileManager.write(data, to: filePathURL)
    }
    
    private func filePathURL(forKey key: String) throws -> URL {
        try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent(key)
    }
    
}
