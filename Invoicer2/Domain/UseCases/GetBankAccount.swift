protocol GetBankAccountProtocol {
    func get() async -> BankAccountDomain?
}

final class GetBankAccount: GetBankAccountProtocol {
    private let companyRepository: CompanyRepositoryProtocol
    private let cacheRepository: CacheRepositoryProtocol
    
    init(
        companyRepository: CompanyRepositoryProtocol = CompanyRepository(),
        cacheRepository: CacheRepositoryProtocol = CacheRepository()
    ){
        self.companyRepository = companyRepository
        self.cacheRepository = cacheRepository
    }
    
    func get() async -> BankAccountDomain? {
        let bankAccount = await companyRepository.getBankAccount()
        return bankAccount ?? cacheRepository.getBankInfo()
    }
}
