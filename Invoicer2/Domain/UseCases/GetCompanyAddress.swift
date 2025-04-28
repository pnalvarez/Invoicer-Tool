protocol GetCompanyAddressProtocol {
    func get() async -> CompanyAddressDomain?
}

final class GetCompanyAddress: GetCompanyAddressProtocol {
    private let companyRepository: CompanyRepositoryProtocol
    private let cacheRepository: CacheRepositoryProtocol
    
    init(
        companyRepository: CompanyRepositoryProtocol = CompanyRepository(),
        cacheRepository: CacheRepositoryProtocol = CacheRepository()
    ) {
        self.companyRepository = companyRepository
        self.cacheRepository = cacheRepository
    }
    
    func get() async -> CompanyAddressDomain? {
        let companyAddress = await companyRepository.getCompanyAddress()
        let cachedValue = cacheRepository.getCompanyAddress()
        return companyAddress ?? cachedValue
    }
    
}
