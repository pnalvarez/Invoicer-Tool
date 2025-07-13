import InvoicerDomainFramework

public final class CompanyRepository: CompanyRepositoryProtocol {
    private let dataSource: StorageDataSourceProtocol
    
    public init(dataSource: StorageDataSourceProtocol = StorageDataSource()) {
        self.dataSource = dataSource
    }
    
    public func saveContractorInfo(_ data: ContractorInfoDomain) async {
        await dataSource.saveContractorInfo(ContractorInfoData.fromDomainModel(data))
    }
    
    public func getContractorInfo() async -> ContractorInfoDomain? {
        await dataSource.getContractorInfo()?.toDomainModel()
    }
    
    public func saveCompanyAddress(_ data: CompanyAddressDomain) async {
        await dataSource.saveCompanyAddress(CompanyAddressData.fromDomainModel(data))
    }
    
    public func getCompanyAddress() async -> CompanyAddressDomain? {
        await dataSource.getCompanyAddress()?.toDomainModel()
    }
    
    public func saveBankAccount(_ data: BankAccountDomain) async {
        await dataSource.saveBankAccount(BankAccountData.fromDomainModel(data))
    }
    
    public func getBankAccount() async -> BankAccountDomain? {
         await dataSource.getBankAccount()?.toDomainModel()
    }
    
    public func saveServiceInfo(_ data: ServiceInfoDomain) async {
        await dataSource.saveServiceInfo(ServiceInfoData.fromDomainModel(data))
    }
    
    public func getServiceInfo() async -> ServiceInfoDomain? {
        await dataSource.getServiceInfo()?.toDomainModel()
    }
    
    public func flushData() async {
        await dataSource.flushData()
    }
}
