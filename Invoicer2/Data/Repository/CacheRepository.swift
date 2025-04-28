final class CacheRepository: CacheRepositoryProtocol {
    private let dataSource: CacheDataSourceProtocol
    
    init(dataSource: CacheDataSourceProtocol = CacheDataSource()) {
        self.dataSource = dataSource
    }
    
    func saveContractorInfo(_ contractorInfo: ContractorInfoDomain?) {
        dataSource.save("contractorInfoCacheKey", value: contractorInfo)
    }
    
    func getContractorInfo() -> ContractorInfoDomain? {
        dataSource.get("contractorInfoCacheKey")
    }
    
    func saveCompanyAddress(_ companyAddress: CompanyAddressDomain?) {
        dataSource.save("companyAddressCacheKey", value: companyAddress)
    }
    
    func getCompanyAddress() -> CompanyAddressDomain? {
        dataSource.get("companyAddressCacheKey")
    }
    
    func saveBankInfo(_ bankInfo: BankAccountDomain?) {
        dataSource.save("bankInfoCacheKey", value: bankInfo)
    }
    
    func getBankInfo() -> BankAccountDomain? {
        dataSource.get("bankInfoCacheKey")
    }
    
    func saveServiceInfo(_ serviceInfo: ServiceInfoDomain?) {
        dataSource.save("saveServiceInfoCacheKey", value: serviceInfo)
    }
    
    func getServiceInfo() -> ServiceInfoDomain? {
        dataSource.get("serviceInfoCacheKey")
    }
}
