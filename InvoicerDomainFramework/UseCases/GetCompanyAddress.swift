public protocol GetCompanyAddressProtocol {
    func get() async -> CompanyAddressDomain?
}

public final class GetCompanyAddress: GetCompanyAddressProtocol {
    private let companyRepository: CompanyRepositoryProtocol
    private let cacheRepository: CacheRepositoryProtocol
    
    public init(
        companyRepository: CompanyRepositoryProtocol,
        cacheRepository: CacheRepositoryProtocol
    ) {
        self.companyRepository = companyRepository
        self.cacheRepository = cacheRepository
    }
    
    public func get() async -> CompanyAddressDomain? {
        let companyAddress = await companyRepository.getCompanyAddress()
        let cachedValue = cacheRepository.getCompanyAddress()
        return companyAddress ?? cachedValue
    }
    
}
