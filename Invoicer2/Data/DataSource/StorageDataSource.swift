protocol StorageDataSourceProtocol {
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


final class StorageDataSource: StorageDataSourceProtocol {
    private let client: StorageClientProtocol
    
    init(client: StorageClientProtocol = StorageClient()) {
        self.client = client
    }
    
    func saveContractorInfo(_ data: ContractorInfoData) async {
        await client.replaceAndSave(newModel: data, where: nil)
    }
    
    func getContractorInfo() async -> ContractorInfoData? {
        let contractorInfo: ContractorInfoData? = await client.fetchSingle()
        return contractorInfo
    }
    
    func saveCompanyAddress(_ data: CompanyAddressData) async {
        await client.replaceAndSave(newModel: data, where: nil)
    }
    
    func getCompanyAddress() async -> CompanyAddressData? {
        return await client.fetchSingle()
    }
    
    func saveBankAccount(_ data: BankAccountData) async {
        await client.replaceAndSave(newModel: data, where: nil)
    }
    
    func getBankAccount() async -> BankAccountData? {
        return await client.fetchSingle()
    }
    
    func saveServiceInfo(_ data: ServiceInfoData) async {
        await client.replaceAndSave(newModel: data, where: nil)
    }
    
    func getServiceInfo() async -> ServiceInfoData? {
        return await client.fetchSingle()
    }
    
    func flushData() async {
        await client.flushAllData()
    }
}
