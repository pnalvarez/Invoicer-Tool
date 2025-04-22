protocol GetBankAccountProtocol {
    func get() async -> BankAccountDomain?
}

final class GetBankAccount: GetBankAccountProtocol {
    private let repository: CompanyRepositoryProtocol
    
    init(repository: CompanyRepositoryProtocol) {
        self.repository = repository
    }
    
    func get() async -> BankAccountDomain? {
        return await repository.getBankAccount()
    }
}
