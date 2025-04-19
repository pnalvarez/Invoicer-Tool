struct OnboardingContractorInfo {
    var fullName: String = ""
    var cnpj: String = ""
    var companyName: String = ""
    var companyEmail: String = ""
}

struct OnboardingCompanyAddress {
    var streetAddress: String = ""
    var city: String = ""
    var neighbourhood: String = ""
    var number: String = ""
    var state: String = ""
    var country: String = ""
    var zipCode: String = ""
}

struct OnboardingBankAccount {
    var benefitiaryName: String = ""
    var bankInfo: OnboardingBankInfo = .init()
    var secondaryBankInfo: OnboardingBankInfo = .init()
}

struct OnboardingBankInfo {
    var iban: String = ""
    var swiftCode: String = ""
    var bankName: String = ""
    var bankAddress: String = ""
}


struct OnboardingServiceInfo {
    var jobDescription: String = ""
    var quantity: String = ""
    var unitPrice: String = ""
}
