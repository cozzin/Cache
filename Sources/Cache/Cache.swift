import Foundation

public class Cache<Value>: CacheStorage where Value: Codable {
    
    private let memory: MemoryCache<Value>
    
    private let disk: DiskCache<Value>
    
    init(memory: MemoryCache<Value> = .init(countLimit: 300), disk: DiskCache<Value> = .init()) {
        self.memory = memory
        self.disk = disk
    }
    
    public func value(forKey key: String) throws -> Value? {
        if let memoryValue = try memory.value(forKey: key) {
            return memoryValue
        }
        
        if let diskValue = try disk.value(forKey: key) {
            try memory.save(diskValue, forKey: key)
            return diskValue
        }
        
        return nil
    }
    
    public func save(_ value: Value, forKey key: String) throws {
        try memory.save(value, forKey: key)
        try disk.save(value, forKey: key)
    }
    
}
