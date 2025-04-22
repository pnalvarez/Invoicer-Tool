protocol SaveContractorInfoProtocol {
    func save(_ contractorInfo: ContractorInfoDomain) async
}

final class SaveContractorInfo: SaveContractorInfoProtocol {
    private let repository: CompanyRepositoryProtocol
    
    init(repository: CompanyRepositoryProtocol) {
        self.repository = repository
    }
    
    func save(_ contractorInfo: ContractorInfoDomain) async {
        await repository.saveContractorInfo(contractorInfo)
    }
}
