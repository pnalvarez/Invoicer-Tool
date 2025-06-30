public protocol CleanCacheProtocol {
    func clean()
}

public final class CleanCache: CleanCacheProtocol {
    private let cacheRepository: CacheRepositoryProtocol
    
    public init(cacheRepository: CacheRepositoryProtocol) {
        self.cacheRepository = cacheRepository
    }
    
    public func clean() {
        cacheRepository.saveContractorInfo(nil)
        cacheRepository.saveCompanyAddress(nil)
        cacheRepository.saveBankInfo(nil)
        cacheRepository.saveServiceInfo(nil)
    }
}

