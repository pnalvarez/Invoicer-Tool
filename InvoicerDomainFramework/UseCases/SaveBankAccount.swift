public protocol SaveBankAccountProtocol {
    func save(_ companyAddress: BankAccountDomain) async
}

public final class SaveBankAccount: SaveBankAccountProtocol{
    private let repository: CompanyRepositoryProtocol
    
    public init(repository: CompanyRepositoryProtocol) {
        self.repository = repository
    }
    
    public func save(_ bankAccount: BankAccountDomain) async {
        await repository.saveBankAccount(bankAccount)
    }
}
