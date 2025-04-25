import Foundation

protocol CacheDataSourceProtocol {
    func save<T: Decodable>(_ key: String, value: T?)
    func get<T: Decodable>(_ key: String) -> T?
}

final class CacheDataSource: CacheDataSourceProtocol {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func save<T: Decodable>(_ key: String, value: T?) {
        userDefaults.set(value, forKey: key)
    }
    
    func get<T: Decodable>(_ key: String) -> T? {
        return userDefaults.object(forKey: key) as? T
    }
}
