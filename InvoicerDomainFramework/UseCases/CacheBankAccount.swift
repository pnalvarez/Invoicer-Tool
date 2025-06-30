public protocol CacheBankAccountProtocol {
    func cache(_ bankAccount: BankAccountDomain?)
}

public final class CacheBankAccount: CacheBankAccountProtocol {
    private let cacheRepository: CacheRepositoryProtocol
    
    public init(cacheRepository: CacheRepositoryProtocol) {
        self.cacheRepository = cacheRepository
    }
    
    public func cache(_ bankAccount: BankAccountDomain?) {
        cacheRepository.saveBankInfo(bankAccount)
    }
}
