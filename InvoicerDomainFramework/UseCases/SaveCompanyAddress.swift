protocol SaveCompanyAddressProtocol {
    func save(_ companyAddress: CompanyAddressDomain) async
}

final class SaveCompanyAddress: SaveCompanyAddressProtocol{
    private let repository: CompanyRepositoryProtocol
    
    init(repository: CompanyRepositoryProtocol = CompanyRepository()) {
        self.repository = repository
    }
    
    func save(_ companyAddress: CompanyAddressDomain) async {
        await repository.saveCompanyAddress(companyAddress)
    }
}
