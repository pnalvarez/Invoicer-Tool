import InvoicerDomainFramework

public final class CacheRepository: CacheRepositoryProtocol {
    private let dataSource: CacheDataSourceProtocol
    
    public init(dataSource: CacheDataSourceProtocol = CacheDataSource()) {
        self.dataSource = dataSource
    }
    
    public func saveContractorInfo(_ contractorInfo: ContractorInfoDomain?) {
        dataSource.save("contractorInfoCacheKey", value: contractorInfo)
    }
    
    public func getContractorInfo() -> ContractorInfoDomain? {
        dataSource.get("contractorInfoCacheKey")
    }
    
    public func saveCompanyAddress(_ companyAddress: CompanyAddressDomain?) {
        dataSource.save("companyAddressCacheKey", value: companyAddress)
    }
    
    public func getCompanyAddress() -> CompanyAddressDomain? {
        dataSource.get("companyAddressCacheKey")
    }
    
    public func saveBankInfo(_ bankInfo: BankAccountDomain?) {
        dataSource.save("bankInfoCacheKey", value: bankInfo)
    }
    
    public func getBankInfo() -> BankAccountDomain? {
        dataSource.get("bankInfoCacheKey")
    }
    
    public func saveServiceInfo(_ serviceInfo: ServiceInfoDomain?) {
        dataSource.save("saveServiceInfoCacheKey", value: serviceInfo)
    }
    
    public func getServiceInfo() -> ServiceInfoDomain? {
        dataSource.get("serviceInfoCacheKey")
    }
}
