public struct ContractorInfoDomain: Codable {
    public let fullName: String
    public let cnpj: String
    public let companyName: String
    public let companyEmail: String
    
    public init(
        fullName: String = "",
        cnpj: String = "",
        companyName: String = "",
        companyEmail: String  = ""
    ) {
        self.fullName = fullName
        self.cnpj = cnpj
        self.companyName = companyName
        self.companyEmail = companyEmail
    }
}
