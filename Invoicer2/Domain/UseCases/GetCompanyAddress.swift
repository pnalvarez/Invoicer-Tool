protocol GetCompanyAddressProtocol {
    func get() async -> CompanyAddressDomain?
}

final class GetCompanyAddress: GetCompanyAddressProtocol {
    private let repository: CompanyRepositoryProtocol
    
    init(repository: CompanyRepositoryProtocol = CompanyRepository()) {
        self.repository = repository
    }
    
    func get() async -> CompanyAddressDomain? {
        return await repository.getCompanyAddress()
    }
    
}
