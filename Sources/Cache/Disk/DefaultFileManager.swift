//
//  DefaultFileManager.swift
//  
//
//  Created by seongho.hong on 2021/10/03.
//

import Foundation

public struct DefaultFileManager: DiskCacheFileManagable {
    
    public init() { }
    
    public func assureDirectoryExists(filePathURL: URL) throws {
        if FileManager.default.fileExists(atPath: filePathURL.path) == false {
            try FileManager.default.createDirectory(at: filePathURL.deletingLastPathComponent(), withIntermediateDirectories: true)
        }
    }
    
    public func filePathURL(forKey key: String) throws -> URL {
        try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent(key)
    }
    
    public func write(_ data: Data, to url: URL) throws {
        try data.write(to: url)
    }
    
    public func data(of url: URL) throws -> Data {
        try Data(contentsOf: url)
    }

}
