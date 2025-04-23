struct OnboardingContractorInfo {
    var fullName: String = ""
    var cnpj: String = ""
    var companyName: String = ""
    var companyEmail: String = ""
    
    func toDomainModel() -> ContractorInfoDomain {
        .init(
            fullName: fullName,
            cnpj: cnpj,
            companyName: companyName,
            companyEmail: companyEmail
        )
    }
}

struct OnboardingCompanyAddress {
    var streetAddress: String = ""
    var city: String = ""
    var neighbourhood: String = ""
    var number: String = ""
    var state: String = ""
    var country: String = ""
    var zipCode: String = ""
    
    func toDomainModel() -> CompanyAddressDomain {
        .init(
            streetAddress: streetAddress,
            city: city,
            neighbourhood: neighbourhood,
            number: number,
            state: state,
            country: country,
            zipCode: zipCode
        )
    }
}

struct OnboardingBankAccount {
    var benefitiaryName: String = ""
    var bankInfo: OnboardingBankInfo = .init()
    var secondaryBankInfo: OnboardingBankInfo = .init()
    
    func toDomainModel() -> BankAccountDomain {
        .init(
            benefitiaryName: benefitiaryName,
            bankInfo: bankInfo.toDomainModel(),
            secondaryBankInfo: secondaryBankInfo.toDomainModel()
        )
    }
}

struct OnboardingBankInfo {
    var iban: String = ""
    var swiftCode: String = ""
    var bankName: String = ""
    var bankAddress: String = ""
    
    func toDomainModel() -> BankInfoDomain {
        .init(
            iban: iban,
            swiftCode: swiftCode,
            bankName: bankName,
            bankAddress: bankAddress
        )
    }
}

struct OnboardingServiceInfo {
    var jobDescription: String = ""
    var quantity: String = ""
    var unitPrice: String = ""
    
    func toDomainModel() -> ServiceInfoDomain {
        .init(
            jobDescription: jobDescription,
            quantity: quantity,
            unitPrice: unitPrice
        )
    }
}
