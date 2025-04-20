struct BankAccountDomain {
    let benefitiaryName: String
    var bankInfo: BankInfoDomain
    var secondaryBankInfo: BankInfoDomain?
}

struct BankInfoDomain {
    let iban: String
    let swiftCode: String
    let bankName: String
    let bankAddress: String
}

