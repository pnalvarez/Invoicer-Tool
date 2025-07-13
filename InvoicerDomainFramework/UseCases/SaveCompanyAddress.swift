public protocol SaveCompanyAddressProtocol {
    func save(_ companyAddress: CompanyAddressDomain) async
}

public final class SaveCompanyAddress: SaveCompanyAddressProtocol{
    private let repository: CompanyRepositoryProtocol
    
    public init(repository: CompanyRepositoryProtocol) {
        self.repository = repository
    }
    
    public func save(_ companyAddress: CompanyAddressDomain) async {
        await repository.saveCompanyAddress(companyAddress)
    }
}
