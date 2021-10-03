# Cache

💾 Simple memory & disk cache

## Usage

### 🧑‍💻 Default

```swift
let cache = Cache<String>()

try memory.save("MyValue", forKey: "MyKey")

let cached = try cache.value(forKey: "MyKey")
```

### 🚀 Advanced

You can also use custom object with `Codable`

```swift
struct CustomObject: Codable {
    let value: Int
}

let memory = MemoryCache<CustomObject>(countLimit: 100)
let disk = DiskCache<CustomObject>(fileManager: fileManager)
let cache = Cache<CustomObject>(memory: memory, disk: disk)

try cache.save(CustomObject(value: 0), forKey: "MyKey")

let cachedValue = try cache.value(forKey: "MyKey")
```

## ♻️ Flow

### Load value

1. Load memory cache if available
2. Load disk cache if available
2-1. then, save to memory cache if value existed in disk cache

### Save value

1. Save memory & cache

## 🧰 Installation
1. In your Xcode project, navigate to File > Swift Packages > Add Package Dependancy...
2. Paste the following into the URL field: https://github.com/cozzin/Cache
