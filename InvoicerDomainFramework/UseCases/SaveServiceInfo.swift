public protocol SaveServiceInfoProtocol {
    func save(_ serviceInfo: ServiceInfoDomain) async
}

public final class SaveServiceInfo: SaveServiceInfoProtocol{
    private let repository: CompanyRepositoryProtocol
    
    public init(repository: CompanyRepositoryProtocol) {
        self.repository = repository
    }
    
    public func save(_ serviceInfo: ServiceInfoDomain) async {
        await repository.saveServiceInfo(serviceInfo)
    }
}
