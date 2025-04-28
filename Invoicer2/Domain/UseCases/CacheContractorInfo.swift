protocol CacheContractorInfoProtocol {
    func cache(_ contractorInfo: ContractorInfoDomain)
}

final class CacheContractorInfo: CacheContractorInfoProtocol {
    private let cacheRepository: CacheRepositoryProtocol
    
    init(cacheRepository: CacheRepositoryProtocol = CacheRepository()) {
        self.cacheRepository = cacheRepository
    }
    
    func cache(_ contractorInfo: ContractorInfoDomain) {
        cacheRepository.saveContractorInfo(contractorInfo)
    }
}

