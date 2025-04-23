protocol GetContractorInfoProtocol {
    func get() async -> ContractorInfoDomain?
}

final class GetContractorInfo: GetContractorInfoProtocol {
    private let repository: CompanyRepositoryProtocol
    
    init(repository: CompanyRepositoryProtocol = CompanyRepository()) {
        self.repository = repository
    }
    
    func get() async -> ContractorInfoDomain? {
        return await repository.getContractorInfo()
    }
    
}
