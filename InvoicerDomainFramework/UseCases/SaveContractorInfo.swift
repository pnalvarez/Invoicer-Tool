protocol SaveContractorInfoProtocol {
    func save(_ contractorInfo: ContractorInfoDomain) async
}

final class SaveContractorInfo: SaveContractorInfoProtocol {
    private let repository: CompanyRepositoryProtocol
    
    init(repository: CompanyRepositoryProtocol = CompanyRepository()) {
        self.repository = repository
    }
    
    func save(_ contractorInfo: ContractorInfoDomain) async {
        await repository.saveContractorInfo(contractorInfo)
    }
}
