protocol CleanCacheProtocol {
    func clean()
}

final class CleanCache: CleanCacheProtocol {
    private let cacheRepository: CacheRepositoryProtocol
    
    init(cacheRepository: CacheRepositoryProtocol = CacheRepository()) {
        self.cacheRepository = cacheRepository
    }
    
    func clean() {
        cacheRepository.saveContractorInfo(nil)
        cacheRepository.saveCompanyAddress(nil)
        cacheRepository.saveBankInfo(nil)
        cacheRepository.saveServiceInfo(nil)
    }
}

