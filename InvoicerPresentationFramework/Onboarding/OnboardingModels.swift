import InvoicerDomainFramework

enum OnboardingStepUI {
    case intro
    case contractorInfo
    case companyAddress
    case bankInfo
    case serviceInfo
    case done
    
    var title: String {
        switch self {
        case .contractorInfo:
            return "Contractor info"
        case .companyAddress:
            return "Company address"
        case .bankInfo:
            return "Bank info"
        case .serviceInfo:
            return "Service info"
        default:
            return ""
        }
    }
    
    var description: String {
        switch self {
        case .contractorInfo:
            return "Please enter your company's information. This is where you tell us who you are and the company you represent as a contractor."
        case .companyAddress:
            return "Now we need to know where your company is located. Please provide the business address of your company, not the company that hired you."
        case .bankInfo:
            return "Enter your company's bank account. This information will be used to process payments for the services you have provided."
        case .serviceInfo:
            return "Describe the service you company provides. We want to know the details about what your company does."
        default:
            return ""
        }
    }
    
    var count: Int {
        switch self {
        case .contractorInfo:
            return 1
        case .companyAddress:
            return 2
        case .bankInfo:
            return 3
        case .serviceInfo:
            return 4
        default:
            return 0
        }
    }
    
    var nextStep: OnboardingStepUI? {
        switch self {
        case .contractorInfo:
            return .companyAddress
        case .companyAddress:
            return .bankInfo
        case .bankInfo:
            return .serviceInfo
        case .serviceInfo:
            return nil
        default:
            return nil
        }
    }
    
    var previousStep: OnboardingStepUI? {
        switch self {
        case .contractorInfo:
            return nil
        case .companyAddress:
            return .contractorInfo
        case .bankInfo:
            return .companyAddress
        case .serviceInfo:
            return .bankInfo
        default:
            return nil
        }
    }
    
    var finishesOnboarding: Bool {
        switch self {
        case .serviceInfo:
            return true
        default:
            return false
        }
    }
    
    var infoDescription: String {
        switch self {
        case .contractorInfo:
            return "Fill the information about yourself and your company."
        case .companyAddress:
            return "Fill the entire address of your company for billing purposes."
        case .bankInfo:
            return "Fill the information about the bank account you want to use for payments."
        case .serviceInfo:
            return "Fill the information about the service your company provides and how much does it cost."
        default:
            return ""
        }
    }
    
    static func fromDomainModel(_ domainModel: OnboardingStepDomain) -> Self {
        switch domainModel {
        case .intro:
            return .intro
        case .contractorInfo:
            return .contractorInfo
        case .companyAddress:
            return .companyAddress
        case .bankAccount:
            return .bankInfo
        case .serviceInfo:
            return .serviceInfo
        case .done:
            return .done
        }
    }
    
    func toDomainModel() -> OnboardingStepDomain {
        switch self {
        case .contractorInfo:
            return .contractorInfo
        case .companyAddress:
            return .companyAddress
        case .bankInfo:
            return .bankAccount
        case .serviceInfo:
            return .serviceInfo
        case .intro:
            return .intro
        case .done:
            return .done
        }
    }
}

struct OnboardingContractorInfo {
    var fullName: String
    var cnpj: String
    var companyName: String
    var companyEmail: String
    
    init(
        fullName: String = "",
        cnpj: String = "",
        companyName: String = "",
        companyEmail: String = ""
    ) {
        self.fullName = fullName
        self.cnpj = cnpj
        self.companyName = companyName
        self.companyEmail = companyEmail
    }
    
    init(domainModel: ContractorInfoDomain) {
        self.fullName = domainModel.fullName
        self.cnpj = domainModel.cnpj
        self.companyName = domainModel.companyName
        self.companyEmail = domainModel.companyEmail
    }
    
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
    var streetAddress: String
    var city: String
    var neighbourhood: String
    var number: String
    var state: String
    var country: String
    var zipCode: String
    
    init(
        streetAddress: String = "",
        city: String = "",
        neighbourhood: String = "",
        number: String = "",
        state: String = "",
        country: String = "",
        zipCode: String = ""
    ) {
        self.streetAddress = streetAddress
        self.city = city
        self.neighbourhood = neighbourhood
        self.number = number
        self.state = state
        self.country = country
        self.zipCode = zipCode
    }
    
    init(domainModel: CompanyAddressDomain) {
        self.streetAddress = domainModel.streetAddress
        self.city = domainModel.city
        self.neighbourhood = domainModel.neighbourhood
        self.number = domainModel.number
        self.state = domainModel.state
        self.country = domainModel.country
        self.zipCode = domainModel.zipCode
    }
    
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
    var benefitiaryName: String
    var bankInfo: OnboardingBankInfo
    var secondaryBankInfo: OnboardingBankInfo
    
    init(
        benefitiaryName: String = "",
        bankInfo: OnboardingBankInfo = .init(),
        secondaryBankInfo: OnboardingBankInfo = .init()
    ) {
        self.benefitiaryName = benefitiaryName
        self.bankInfo = bankInfo
        self.secondaryBankInfo = secondaryBankInfo
    }
    
    init(domainModel: BankAccountDomain) {
        self.benefitiaryName = domainModel.benefitiaryName
        self.bankInfo = .init(domainModel: domainModel.bankInfo)
        if let secondaryBankInfo = domainModel.secondaryBankInfo {
            self.secondaryBankInfo = .init(domainModel: secondaryBankInfo)
        } else {
            self.secondaryBankInfo = .init()
        }
    }
    
    func toDomainModel() -> BankAccountDomain {
        .init(
            benefitiaryName: benefitiaryName,
            bankInfo: bankInfo.toDomainModel(),
            secondaryBankInfo: secondaryBankInfo.toDomainModel()
        )
    }
}

struct OnboardingBankInfo {
    var iban: String
    var swiftCode: String
    var bankName: String
    var bankAddress: String
    
    init(domainModel: BankInfoDomain) {
        self.iban = domainModel.iban
        self.swiftCode = domainModel.swiftCode
        self.bankName = domainModel.bankName
        self.bankAddress = domainModel.bankAddress
    }
    
    init(
        iban: String = "",
        swiftCode: String = "",
        bankName: String = "",
        bankAddress: String = ""
    ) {
        self.iban = iban
        self.swiftCode = swiftCode
        self.bankName = bankName
        self.bankAddress = bankAddress
    }
    
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
    var jobDescription: String
    var quantity: String
    var unitPrice: String
    
    init(domainModel: ServiceInfoDomain) {
        self.jobDescription = domainModel.jobDescription
        self.quantity = domainModel.quantity
        self.unitPrice = domainModel.unitPrice
    }
    
    init(
        jobDescription: String = "",
        quantity: String = "",
        unitPrice: String = ""
    ) {
        self.jobDescription = jobDescription
        self.quantity = quantity
        self.unitPrice = unitPrice
    }
    
    func toDomainModel() -> ServiceInfoDomain {
        .init(
            jobDescription: jobDescription,
            quantity: quantity,
            unitPrice: unitPrice
        )
    }
}

struct OnboardingFieldValidation {
    var fullNameHasError: Bool = true
    var taxIdHasError: Bool = true
    var companyNameHasError: Bool = true
    var companyEmailHasError: Bool = true
    var streetAddressHasError: Bool = true
    var cityHasError: Bool = true
    var stateHasError: Bool = true
    var zipCodeHasError: Bool = true
    var countryHasError: Bool = true
    var neighbourhoodHasError: Bool = true
    var numberHasError: Bool = true
    var benefitiaryNameHasError: Bool = true
    var accountNumberHasError: Bool = true
    var swiftCodeHasError: Bool = true
    var bankNameHasError: Bool = true
    var bankAddressHasError: Bool = true
    var secondaryBenefitiaryNameHasError: Bool = true
    var secondaryAccountNumberHasError: Bool = true
    var secondarySwiftCodeHasError: Bool = true
    var secondaryBankNameHasError: Bool = true
    var secondaryBankAddressHasError: Bool = true
    var jobDescriptionHasError: Bool = true
    var quantityHasError: Bool = true
    var unitPriceHasError: Bool = true
}
