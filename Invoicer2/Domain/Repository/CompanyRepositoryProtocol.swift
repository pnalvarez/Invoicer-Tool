protocol CompanyRepositoryProtocol {
    func saveContractorInfo(_ data: ContractorInfoDomain) async
    func getContractorInfo() async -> ContractorInfoDomain?
    func saveCompanyAddress(_ data: CompanyAddressDomain) async
    func getCompanyAddress() async -> CompanyAddressDomain?
    func saveBankAccount(_ data: BankAccountDomain) async
    func getBankAccount() async -> BankAccountDomain?
    func saveServiceInfo(_ data: ServiceInfoDomain) async
    func getServiceInfo() async -> ServiceInfoDomain?
}
