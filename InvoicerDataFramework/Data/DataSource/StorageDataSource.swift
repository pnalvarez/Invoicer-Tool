public protocol StorageDataSourceProtocol {
    func saveContractorInfo(_ data: ContractorInfoData) async
    func getContractorInfo() async -> ContractorInfoData?
    func saveCompanyAddress(_ data: CompanyAddressData) async
    func getCompanyAddress() async -> CompanyAddressData?
    func saveBankAccount(_ data: BankAccountData) async
    func getBankAccount() async -> BankAccountData?
    func saveServiceInfo(_ data: ServiceInfoData) async
    func getServiceInfo() async -> ServiceInfoData?
    func flushData() async
}


public final class StorageDataSource: StorageDataSourceProtocol {
    private let client: StorageClientProtocol
    
    public init(client: StorageClientProtocol = StorageClient()) {
        self.client = client
    }
    
    public func saveContractorInfo(_ data: ContractorInfoData) async {
        await client.replaceAndSave(newModel: data, where: nil)
    }
    
    public func getContractorInfo() async -> ContractorInfoData? {
        let contractorInfo: ContractorInfoData? = await client.fetchSingle()
        return contractorInfo
    }
    
    public func saveCompanyAddress(_ data: CompanyAddressData) async {
        await client.replaceAndSave(newModel: data, where: nil)
    }
    
    public func getCompanyAddress() async -> CompanyAddressData? {
        return await client.fetchSingle()
    }
    
    public func saveBankAccount(_ data: BankAccountData) async {
        await client.replaceAndSave(newModel: data, where: nil)
    }
    
    public func getBankAccount() async -> BankAccountData? {
        return await client.fetchSingle()
    }
    
    public func saveServiceInfo(_ data: ServiceInfoData) async {
        await client.replaceAndSave(newModel: data, where: nil)
    }
    
    public func getServiceInfo() async -> ServiceInfoData? {
        return await client.fetchSingle()
    }
    
    public func flushData() async {
        await client.flushAllData()
    }
}
