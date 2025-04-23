protocol GetServiceInfoProtocol {
    func get() async -> ServiceInfoDomain?
}

final class GetServiceInfo: GetServiceInfoProtocol {
    private let repository: CompanyRepositoryProtocol
    
    init(repository: CompanyRepositoryProtocol = CompanyRepository()) {
        self.repository = repository
    }
    
    func get() async -> ServiceInfoDomain? {
        return await repository.getServiceInfo()
    }
    
}
