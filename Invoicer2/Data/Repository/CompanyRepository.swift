final class CompanyRepository: CompanyRepositoryProtocol {
    private let dataSource: StorageDataSourceProtocol
    
    init(dataSource: StorageDataSourceProtocol = StorageDataSource()) {
        self.dataSource = dataSource
    }
    
    func saveContractorInfo(_ data: ContractorInfoDomain) async {
        await dataSource.saveContractorInfo(ContractorInfoData.fromDomainModel(data))
    }
    
    func getContractorInfo() async -> ContractorInfoDomain? {
        await dataSource.getContractorInfo()?.toDomainModel()
    }
    
    func saveCompanyAddress(_ data: CompanyAddressDomain) async {
        await dataSource.saveCompanyAddress(CompanyAddressData.fromDomainModel(data))
    }
    
    func getCompanyAddress() async -> CompanyAddressDomain? {
        await dataSource.getCompanyAddress()?.toDomainModel()
    }
    
    func saveBankAccount(_ data: BankAccountDomain) async {
        await dataSource.saveBankAccount(BankAccountData.fromDomainModel(data))
    }
    
    func getBankAccount() async -> BankAccountDomain? {
         await dataSource.getBankAccount()?.toDomainModel()
    }
    
    func saveServiceInfo(_ data: ServiceInfoDomain) async {
        await dataSource.saveServiceInfo(ServiceInfoData.fromDomainModel(data))
    }
    
    func getServiceInfo() async -> ServiceInfoDomain? {
        await dataSource.getServiceInfo()?.toDomainModel()
    }
    
}
