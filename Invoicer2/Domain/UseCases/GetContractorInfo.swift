protocol GetContractorInfoProtocol {
    func get() async -> ContractorInfoDomain?
}

final class GetContractorInfoU: GetContractorInfoProtocol {
    private let repository: CompanyRepositoryProtocol
    
    init(repository: CompanyRepositoryProtocol) {
        self.repository = repository
    }
    
    func get() async -> ContractorInfoDomain? {
        return await repository.getContractorInfo()
    }
    
}
