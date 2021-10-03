import XCTest
@testable import Cache

final class DiskCacheTests: XCTestCase {

    private var fileManager: DiskCacheFileManagerFake!
    
    override func setUp() {
        super.setUp()
        
        fileManager = DiskCacheFileManagerFake()
    }
    
    func testStringCache() throws {
        // given
        let cache = DiskCache<String>(fileManager: fileManager)
        
        // when
        try cache.save("MyValue", forKey: "MyKey")
        
        // then
        let result = try cache.value(forKey: "MyKey")
        XCTAssertEqual(result, "MyValue")
    }
    
    func testIntCache() throws {
        // given
        let cache = DiskCache<Int>(fileManager: fileManager)
        
        // when
        try cache.save(0, forKey: "MyKey")
        
        // then
        let result = try cache.value(forKey: "MyKey")
        XCTAssertEqual(result, 0)
    }
    
    func testObjectCache() throws {
        // given
        let cache = DiskCache<ObjectStub>(fileManager: fileManager)

        // when
        let object = ObjectStub(value: 0)
        try cache.save(object, forKey: "MyKey")
        
        // then
        let result = try cache.value(forKey: "MyKey")
        XCTAssertEqual(result!.value, 0)
    }
    
    func testEmptyCache() throws {
        // given
        let cache = DiskCache<String>(fileManager: fileManager)
                
        // then
        let result = try cache.value(forKey: "MyKey")
        XCTAssertNil(result, "MyValue")
    }
    
}
