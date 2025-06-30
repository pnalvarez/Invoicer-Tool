public protocol CacheServiceInfoProtocol {
    func cache(_ serviceInfo: ServiceInfoDomain)
}

public final class CacheServiceInfo: CacheServiceInfoProtocol {
    private let cacheRepository: CacheRepositoryProtocol
    
    public init(cacheRepository: CacheRepositoryProtocol) {
        self.cacheRepository = cacheRepository
    }
    
    public func cache(_ serviceInfo: ServiceInfoDomain) {
        cacheRepository.saveServiceInfo(serviceInfo)
    }
}
