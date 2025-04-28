protocol GetContractorInfoProtocol {
    func get() async -> ContractorInfoDomain?
}

final class GetContractorInfo: GetContractorInfoProtocol {
    private let companyRepository: CompanyRepositoryProtocol
    private let cacheRepository: CacheRepositoryProtocol
    
    init(
        companyRepository: CompanyRepositoryProtocol = CompanyRepository(),
        cacheRepository: CacheRepositoryProtocol = CacheRepository()
    ) {
        self.companyRepository = companyRepository
        self.cacheRepository = cacheRepository
    }
    
    func get() async -> ContractorInfoDomain? {
        let contractorInfo = await companyRepository.getContractorInfo()
        return contractorInfo ?? cacheRepository.getContractorInfo()
    }
    
}
