//
//  DiskCacheFileManagable.swift
//  
//
//  Created by seongho.hong on 2021/10/03.
//

import Foundation

public protocol DiskCacheFileManagable {
    func assureDirectoryExists(filePathURL: URL) throws
    func filePathURL(forKey key: String) throws -> URL
    func write(_ data: Data, to url: URL) throws
    func data(of url: URL) throws -> Data
}
