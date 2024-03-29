import XCTest
@testable import Cache

final class MemoryStorageTests: XCTestCase {

    func testStringCache() throws {
        // given
        let cache = MemoryCache<String>(countLimit: 1)
        
        // when
        try cache.save("MyValue", forKey: "MyKey")
        
        // then
        let result = try cache.value(forKey: "MyKey")
        XCTAssertEqual(result, "MyValue")
    }
    
    func testIntCache() throws {
        // given
        let cache = MemoryCache<Int>(countLimit: 1)
        
        // when
        try cache.save(0, forKey: "MyKey")
        
        // then
        let result = try cache.value(forKey: "MyKey")
        XCTAssertEqual(result, 0)
    }
    
    func testObjectCache() throws {
        // given
        let cache = MemoryCache<ObjectStub>(countLimit: 1)

        // when
        let object = ObjectStub(value: 0)
        try cache.save(object, forKey: "MyKey")
        
        // then
        let result = try cache.value(forKey: "MyKey")
        XCTAssertEqual(result!.value, 0)
    }
    
    func testCountLimit() throws {
        // given
        let cache = MemoryCache<Int>(countLimit: 1)
        
        // when
        try cache.save(0, forKey: "MyKey0")
        try cache.save(1, forKey: "MyKey1")

        // then
        XCTAssertNil(try cache.value(forKey: "MyKey0"))
        XCTAssertEqual(try cache.value(forKey: "MyKey1"), 1)
    }

}
