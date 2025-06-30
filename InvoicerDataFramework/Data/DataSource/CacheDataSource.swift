import Foundation

public protocol CacheDataSourceProtocol {
    func save<T: Codable>(_ key: String, value: T?)
    func get<T: Codable>(_ key: String) -> T?
}

public final class CacheDataSource: CacheDataSourceProtocol {
    private let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    public func save<T: Codable>(_ key: String, value: T?) {
        do {
            guard let value else {
                userDefaults.removeObject(forKey: key)
                return
            }
            let data = try JSONEncoder().encode(value)
            userDefaults.set(data, forKey: key)
        } catch {
            print("❌ Failed to encode ContractorInfoDomain: \(error)")
        }
    }
    
    public func get<T: Codable>(_ key: String) -> T? {
        do {
            guard let data = userDefaults.data(forKey: key) else { return nil }
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("❌ Failed to encode ContractorInfoDomain: \(error)")
            return nil
        }
    }
}
