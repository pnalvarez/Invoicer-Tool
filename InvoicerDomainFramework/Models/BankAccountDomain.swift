public struct BankAccountDomain: Codable {
    public let benefitiaryName: String
    public var bankInfo: BankInfoDomain
    public var secondaryBankInfo: BankInfoDomain?
    
    public init(benefitiaryName: String, bankInfo: BankInfoDomain, secondaryBankInfo: BankInfoDomain? = nil) {
        self.benefitiaryName = benefitiaryName
        self.bankInfo = bankInfo
        self.secondaryBankInfo = secondaryBankInfo
    }
}

public struct BankInfoDomain: Codable {
    public let iban: String
    public let swiftCode: String
    public let bankName: String
    public let bankAddress: String
    
    public init(iban: String, swiftCode: String, bankName: String, bankAddress: String) {
        self.iban = iban
        self.swiftCode = swiftCode
        self.bankName = bankName
        self.bankAddress = bankAddress
    }
}

