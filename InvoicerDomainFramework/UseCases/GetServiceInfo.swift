public protocol GetServiceInfoProtocol {
    func get() async -> ServiceInfoDomain?
}

public final class GetServiceInfo: GetServiceInfoProtocol {
    private let companyRepository: CompanyRepositoryProtocol
    private let cacheRepository: CacheRepositoryProtocol
    
    public init(
        companyRepository: CompanyRepositoryProtocol,
        cacheRepository: CacheRepositoryProtocol
    ){
        self.companyRepository = companyRepository
        self.cacheRepository = cacheRepository
    }
    
    public func get() async -> ServiceInfoDomain? {
        let serviceInfo = await companyRepository.getServiceInfo()
        return serviceInfo ?? cacheRepository.getServiceInfo()
    }
    
}
