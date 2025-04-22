protocol SaveServiceInfoProtocol {
    func save(_ serviceInfo: ServiceInfoDomain) async
}

final class SaveServiceInfo: SaveServiceInfoProtocol{
    private let repository: CompanyRepositoryProtocol
    
    init(repository: CompanyRepositoryProtocol) {
        self.repository = repository
    }
    
    func save(_ serviceInfo: ServiceInfoDomain) async {
        await repository.saveServiceInfo(serviceInfo)
    }
}
