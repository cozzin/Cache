import XCTest
@testable import Cache

final class CacheTests: XCTestCase {
    
    private var fileManager: DiskCacheFileManagerFake!
    
    override func setUp() {
        super.setUp()
        
        fileManager = DiskCacheFileManagerFake()
    }
    
    func testCache_onlySavedInMemory() throws {
        // given
        let memory = MemoryCache<String>(countLimit: 1)
        let disk = DiskCache<String>(fileManager: fileManager)
        let cache = Cache<String>(memory: memory, disk: disk)
        try memory.save("MyValue", forKey: "MyKey")
        
        // when
        _ = try cache.value(forKey: "MyKey")
        
        // then
        XCTAssertEqual(try memory.value(forKey: "MyKey"), "MyValue")
        XCTAssertNil(try disk.value(forKey: "MyKey"))
    }
    
    func testCache_onlySavedInDisk() throws {
        // given
        let memory = MemoryCache<String>(countLimit: 1)
        let disk = DiskCache<String>(fileManager: fileManager)
        let cache = Cache<String>(memory: memory, disk: disk)
        try disk.save("MyValue", forKey: "MyKey")
        
        // when
        _ = try cache.value(forKey: "MyKey")
        
        // then
        let result = try memory.value(forKey: "MyKey")
        XCTAssertEqual(result, "MyValue")
    }
    
    func testEmptyCache() throws {
        // given
        let memory = MemoryCache<String>(countLimit: 1)
        let disk = DiskCache<String>(fileManager: fileManager)
        let cache = Cache<String>(memory: memory, disk: disk)
        
        // then
        let result = try cache.value(forKey: "MyKey")
        XCTAssertNil(result, "MyValue")
    }
    
}
