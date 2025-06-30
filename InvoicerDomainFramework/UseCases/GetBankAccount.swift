public protocol GetBankAccountProtocol {
    func get() async -> BankAccountDomain?
}

public final class GetBankAccount: GetBankAccountProtocol {
    private let companyRepository: CompanyRepositoryProtocol
    private let cacheRepository: CacheRepositoryProtocol
    
    public init(
        companyRepository: CompanyRepositoryProtocol,
        cacheRepository: CacheRepositoryProtocol
    ){
        self.companyRepository = companyRepository
        self.cacheRepository = cacheRepository
    }
    
    public func get() async -> BankAccountDomain? {
        let bankAccount = await companyRepository.getBankAccount()
        return bankAccount ?? cacheRepository.getBankInfo()
    }
}
