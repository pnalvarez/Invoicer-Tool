protocol CacheBankAccountProtocol {
    func cache(_ bankAccount: BankAccountDomain?)
}

final class CacheBankAccount: CacheBankAccountProtocol {
    private let cacheRepository: CacheRepositoryProtocol
    
    init(cacheRepository: CacheRepositoryProtocol = CacheRepository()) {
        self.cacheRepository = cacheRepository
    }
    
    func cache(_ bankAccount: BankAccountDomain?) {
        cacheRepository.saveBankInfo(bankAccount)
    }
}
