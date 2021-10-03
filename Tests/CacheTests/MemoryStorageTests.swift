import XCTest
@testable import Cache

final class MemoryStorageTests: XCTestCase {

    func testStringCache() throws {
        // given
        let cache = MemoryStorage<String>(countLimit: 1)
        
        // when
        cache.save("MyValue", forKey: "MyKey")
        
        // then
        let result = cache.value(forKey: "MyKey")
        XCTAssertEqual(result, "MyValue")
    }
    
    func testIntCache() throws {
        // given
        let cache = MemoryStorage<Int>(countLimit: 1)
        
        // when
        cache.save(0, forKey: "MyKey")
        
        // then
        let result = cache.value(forKey: "MyKey")
        XCTAssertEqual(result, 0)
    }
    
    func testObjectCache() throws {
        // given
        let cache = MemoryStorage<ObjectStub>(countLimit: 1)

        // when
        let object = ObjectStub(value: 0)
        cache.save(object, forKey: "MyKey")
        
        // then
        let result = cache.value(forKey: "MyKey")
        XCTAssertEqual(result!.value, 0)
    }
    
    func testCountLimit() throws {
        // given
        let cache = MemoryStorage<Int>(countLimit: 1)
        
        // when
        cache.save(0, forKey: "MyKey0")
        cache.save(1, forKey: "MyKey1")

        // then
        XCTAssertNil(cache.value(forKey: "MyKey0"))
        XCTAssertEqual(cache.value(forKey: "MyKey1"), 1)
    }

}

// MARK: - ObjectStub

struct ObjectStub: Codable {
    let value: Int
}
