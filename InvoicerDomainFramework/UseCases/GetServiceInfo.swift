protocol GetServiceInfoProtocol {
    func get() async -> ServiceInfoDomain?
}

final class GetServiceInfo: GetServiceInfoProtocol {
    private let companyRepository: CompanyRepositoryProtocol
    private let cacheRepository: CacheRepositoryProtocol
    
    init(
        companyRepository: CompanyRepositoryProtocol = CompanyRepository(),
        cacheRepository: CacheRepositoryProtocol = CacheRepository()
    ){
        self.companyRepository = companyRepository
        self.cacheRepository = cacheRepository
    }
    
    func get() async -> ServiceInfoDomain? {
        let serviceInfo = await companyRepository.getServiceInfo()
        return serviceInfo ?? cacheRepository.getServiceInfo()
    }
    
}
