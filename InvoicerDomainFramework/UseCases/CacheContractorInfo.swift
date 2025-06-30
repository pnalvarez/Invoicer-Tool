public protocol CacheContractorInfoProtocol {
    func cache(_ contractorInfo: ContractorInfoDomain)
}

public final class CacheContractorInfo: CacheContractorInfoProtocol {
    private let cacheRepository: CacheRepositoryProtocol
    
    public init(cacheRepository: CacheRepositoryProtocol) {
        self.cacheRepository = cacheRepository
    }
    
    public func cache(_ contractorInfo: ContractorInfoDomain) {
        cacheRepository.saveContractorInfo(contractorInfo)
    }
}

