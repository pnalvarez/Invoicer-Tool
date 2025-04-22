protocol SaveCompanyAddressProtocol {
    func save(_ companyAddress: CompanyAddressDomain) async
}

final class SaveCompanyAddress: SaveCompanyAddressProtocol{
    private let repository: CompanyRepositoryProtocol
    
    init(repository: CompanyRepositoryProtocol) {
        self.repository = repository
    }
    
    func save(_ companyAddress: CompanyAddressDomain) async {
        await repository.saveCompanyAddress(companyAddress)
    }
}
