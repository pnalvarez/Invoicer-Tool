protocol SaveBankAccountProtocol {
    func save(_ companyAddress: BankAccountDomain) async
}

final class SaveBankAccount: SaveBankAccountProtocol{
    private let repository: CompanyRepositoryProtocol
    
    init(repository: CompanyRepositoryProtocol = CompanyRepository()) {
        self.repository = repository
    }
    
    func save(_ bankAccount: BankAccountDomain) async {
        await repository.saveBankAccount(bankAccount)
    }
}
