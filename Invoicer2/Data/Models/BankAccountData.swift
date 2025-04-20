import SwiftData

@Model final class BankAccountData {
    @Attribute var beneficiaryName: String
    @Attribute var bankInfo: BankInfoData
    @Attribute var secondaryBankInfo: BankInfoData?
    
    init(
        beneficiaryName: String,
        bankInfo: BankInfoData,
        secondaryBankInfo: BankInfoData? = nil
    ) {
        self.beneficiaryName = beneficiaryName
        self.bankInfo = bankInfo
        self.secondaryBankInfo = secondaryBankInfo
    }
    
    static func fromDomainModel(_ model: BankAccountDomain) -> Self {
        guard let secondaryBankInfo = model.secondaryBankInfo else {
            return .init(
                beneficiaryName: model.benefitiaryName,
                bankInfo: .fromDomainModel(model.bankInfo)
            )
        }
        
        return .init(
            beneficiaryName: model.benefitiaryName,
            bankInfo: .fromDomainModel(model.bankInfo),
            secondaryBankInfo: .fromDomainModel(secondaryBankInfo)
        )
    }
    
    func toDomainModel() -> BankAccountDomain {
        return .init(
            benefitiaryName: beneficiaryName,
            bankInfo: bankInfo.toDomainModel(),
            secondaryBankInfo: secondaryBankInfo?.toDomainModel(),
        )
    }
}

@Model final class BankInfoData {
    @Attribute var iban: String
    @Attribute var swiftCode: String
    @Attribute var bankName: String
    @Attribute var bankAddress: String
    
    init(
        iban: String,
        swiftCode: String,
        bankName: String,
        bankAddress: String
    ) {
        self.iban = iban
        self.swiftCode = swiftCode
        self.bankName = bankName
        self.bankAddress = bankAddress
    }
    
    static func fromDomainModel(_ model: BankInfoDomain) -> Self {
        return .init(
            iban: model.iban,
            swiftCode: model.swiftCode,
            bankName: model.bankName,
            bankAddress: model.bankAddress
        )
    }
    
    func toDomainModel() -> BankInfoDomain {
        return .init(
            iban: iban,
            swiftCode: swiftCode,
            bankName: bankName,
            bankAddress: bankAddress
        )
    }
}

