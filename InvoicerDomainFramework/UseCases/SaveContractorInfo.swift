public protocol SaveContractorInfoProtocol {
    func save(_ contractorInfo: ContractorInfoDomain) async
}

public final class SaveContractorInfo: SaveContractorInfoProtocol {
    private let repository: CompanyRepositoryProtocol
    
    public init(repository: CompanyRepositoryProtocol) {
        self.repository = repository
    }
    
    public func save(_ contractorInfo: ContractorInfoDomain) async {
        await repository.saveContractorInfo(contractorInfo)
    }
}
