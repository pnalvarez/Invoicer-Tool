import Foundation

protocol CacheDataSourceProtocol {
    func save<T: Codable>(_ key: String, value: T?)
    func get<T: Codable>(_ key: String) -> T?
}

final class CacheDataSource: CacheDataSourceProtocol {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func save<T: Codable>(_ key: String, value: T?) {
        do {
            guard let value else { return }
            let data = try JSONEncoder().encode(value)
            userDefaults.set(data, forKey: key)
        } catch {
            print("❌ Failed to encode ContractorInfoDomain: \(error)")
        }
    }
    
    func get<T: Codable>(_ key: String) -> T? {
        do {
            guard let data = userDefaults.data(forKey: key) else { return nil }
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("❌ Failed to encode ContractorInfoDomain: \(error)")
            return nil
        }
    }
}
