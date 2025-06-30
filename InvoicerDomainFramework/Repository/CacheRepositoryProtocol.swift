public protocol CacheRepositoryProtocol {
    func saveContractorInfo(_ contractorInfo: ContractorInfoDomain?)
    func getContractorInfo() -> ContractorInfoDomain?
    func saveCompanyAddress(_ companyAddress: CompanyAddressDomain?)
    func getCompanyAddress() -> CompanyAddressDomain?
    func saveBankInfo(_ bankInfo: BankAccountDomain?)
    func getBankInfo() -> BankAccountDomain?
    func saveServiceInfo(_ serviceInfo: ServiceInfoDomain?)
    func getServiceInfo() -> ServiceInfoDomain?
}
