protocol CacheCompanyAddressProtocol {
    func cache(_ companyAddress: CompanyAddressDomain)
}

final class CacheCompanyAddress: CacheCompanyAddressProtocol {
    private let cacheRepository: CacheRepositoryProtocol
    
    init(cacheRepository: CacheRepositoryProtocol = CacheRepository()) {
        self.cacheRepository = cacheRepository
    }
    
    func cache(_ companyAddress: CompanyAddressDomain) {
        cacheRepository.saveCompanyAddress(companyAddress)
    }
}
