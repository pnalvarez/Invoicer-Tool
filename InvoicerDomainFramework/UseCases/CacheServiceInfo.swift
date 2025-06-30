protocol CacheServiceInfoProtocol {
    func cache(_ serviceInfo: ServiceInfoDomain)
}

final class CacheServiceInfo: CacheServiceInfoProtocol {
    private let cacheRepository: CacheRepositoryProtocol
    
    init(cacheRepository: CacheRepositoryProtocol = CacheRepository()) {
        self.cacheRepository = cacheRepository
    }
    
    func cache(_ serviceInfo: ServiceInfoDomain) {
        cacheRepository.saveServiceInfo(serviceInfo)
    }
}
