//
//  DiskCacheFileManagerFake.swift
//  
//
//  Created by seongho.hong on 2021/10/03.
//

import Foundation
import Cache

final class DiskCacheFileManagerFake: DiskCacheFileManagable {
    
    enum Exception: Error {
        case dataNotExist
    }
    
    private var directory: [URL: Data] = [:]

    func assureDirectoryExists(filePathURL: URL) throws {
        
    }
    
    func filePathURL(forKey key: String) throws -> URL {
        URL(string: "file://")!
    }
    
    func write(_ data: Data, to url: URL) throws {
        directory[url] = data
    }
    
    func data(of url: URL) throws -> Data {
        guard let data = directory[url] else {
            throw Exception.dataNotExist
        }
        
        return data
    }
    
}
