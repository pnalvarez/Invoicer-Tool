public protocol CacheCompanyAddressProtocol {
    func cache(_ companyAddress: CompanyAddressDomain)
}

public final class CacheCompanyAddress: CacheCompanyAddressProtocol {
    private let cacheRepository: CacheRepositoryProtocol
    
    public init(cacheRepository: CacheRepositoryProtocol) {
        self.cacheRepository = cacheRepository
    }
    
    public func cache(_ companyAddress: CompanyAddressDomain) {
        cacheRepository.saveCompanyAddress(companyAddress)
    }
}
