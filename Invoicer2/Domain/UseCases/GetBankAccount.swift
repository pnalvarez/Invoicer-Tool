protocol GetBankAccountProtocol {
    func get() async -> BankAccountDomain?
}

final class GetBankAccount: GetBankAccountProtocol {
    private let repository: CompanyRepositoryProtocol
    
    init(repository: CompanyRepositoryProtocol = CompanyRepository()) {
        self.repository = repository
    }
    
    func get() async -> BankAccountDomain? {
        return await repository.getBankAccount()
    }
}
