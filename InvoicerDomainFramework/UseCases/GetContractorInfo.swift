public protocol GetContractorInfoProtocol {
    func get() async -> ContractorInfoDomain?
}

public final class GetContractorInfo: GetContractorInfoProtocol {
    private let companyRepository: CompanyRepositoryProtocol
    private let cacheRepository: CacheRepositoryProtocol
    
    public init(
        companyRepository: CompanyRepositoryProtocol,
        cacheRepository: CacheRepositoryProtocol
    ) {
        self.companyRepository = companyRepository
        self.cacheRepository = cacheRepository
    }
    
    public func get() async -> ContractorInfoDomain? {
        let contractorInfo = await companyRepository.getContractorInfo()
        return contractorInfo ?? cacheRepository.getContractorInfo()
    }
    
}
