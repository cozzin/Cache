//
//  DefaultFileManager.swift
//  
//
//  Created by seongho.hong on 2021/10/03.
//

import Foundation

struct DefaultFileManager: DiskCacheFileManagable {
    
    func assureDirectoryExists(filePathURL: URL) throws {
        if FileManager.default.fileExists(atPath: filePathURL.path) == false {
            try FileManager.default.createDirectory(at: filePathURL.deletingLastPathComponent(), withIntermediateDirectories: true)
        }
    }
    
    func filePathURL(forKey key: String) throws -> URL {
        try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent(key)
    }
    
    func write(_ data: Data, to url: URL) throws {
        try data.write(to: url)
    }
    
    func data(of url: URL) throws -> Data {
        try Data(contentsOf: url)
    }

}
