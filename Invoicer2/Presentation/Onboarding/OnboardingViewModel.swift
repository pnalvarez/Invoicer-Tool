import Combine

enum OnboardingStep {
    case contractorInfo
    case companyAddress
    case bankInfo
    case serviceInfo
    
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
        }
    }
    
    var nextStep: OnboardingStep? {
        switch self {
        case .contractorInfo:
            return .companyAddress
        case .companyAddress:
            return .bankInfo
        case .bankInfo:
            return .serviceInfo
        case .serviceInfo:
            return nil
        }
    }
    
    var previousStep: OnboardingStep? {
        switch self {
        case .contractorInfo:
            return nil
        case .companyAddress:
            return .contractorInfo
        case .bankInfo:
            return .companyAddress
        case .serviceInfo:
            return .bankInfo
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
}

final class OnboardingViewModel: ObservableObject {
    @Published var contractorInfo: OnboardingContractorInfo = .init()
    @Published var companyAddress: OnboardingCompanyAddress = .init()
    @Published var bankAccountInfo: OnboardingBankAccount = .init()
    @Published var serviceInfo: OnboardingServiceInfo = .init()
    @Published var step: OnboardingStep = .contractorInfo
    
    @Published var shouldShowSecondaryBankForms: Bool = false
    
    @Published var ctaEnabled: Bool = false
    
    @Published var fullNameHasError: Bool = true
    @Published var taxIdHasError: Bool = true
    @Published var companyNameHasError: Bool = true
    @Published var companyEmailHasError: Bool = true
    @Published var streetAddressHasError: Bool = true
    @Published var cityHasError: Bool = true
    @Published var stateHasError: Bool = true
    @Published var zipCodeHasError: Bool = true
    @Published var countryHasError: Bool = true
    @Published var neighbourhoodHasError: Bool = true
    @Published var numberHasError: Bool = true
    @Published var benefitiaryNameHasError: Bool = true
    @Published var accountNumberHasError: Bool = true
    @Published var swiftCodeHasError: Bool = true
    @Published var bankNameHasError: Bool = true
    @Published var bankAddressHasError: Bool = true
    @Published var secondaryBenefitiaryNameHasError: Bool = true
    @Published var secondaryAccountNumberHasError: Bool = true
    @Published var secondarySwiftCodeHasError: Bool = true
    @Published var secondaryBankNameHasError: Bool = true
    @Published var secondaryBankAddressHasError: Bool = true
    @Published var jobDescriptionHasError: Bool = true
    @Published var quantityHasError: Bool = true
    @Published var unitPriceHasError: Bool = true
    
    private var disposeBag: Set<AnyCancellable> = []
    
    private let coordinator: OnboardingCoordinatorProtocol
    
    init(coordinator: OnboardingCoordinatorProtocol) {
        self.coordinator = coordinator
        setUpSubscriptions()
    }
    
    func didTapBack() {
        guard let previousStep = step.previousStep else {
            coordinator.navigateBack()
            return
        }
        step = previousStep
        ctaEnabled = true
    }
    
    func didTapCTA() {
        goToNextStep()
    }
    
    private func goToNextStep() {
        if step.finishesOnboarding {
            coordinator.navigateToInvoiceList()
        } else {
            if let nextStep = step.nextStep  {
                step = nextStep
            }
        }
    }
    
    private func setUpSubscriptions() {
        setUpFieldValidation()
        setUpCTAValidation()
    }
    
    private func setUpFieldValidation() {
        $contractorInfo
            .mapDistinct(\.fullName)
            .sink { [weak self] in
                self?.fullNameHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $contractorInfo
            .mapDistinct(\.cnpj)
            .sink { [weak self] in
                self?.taxIdHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $contractorInfo
            .mapDistinct(\.companyName)
            .sink { [weak self] in
                self?.companyNameHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $contractorInfo
            .mapDistinct(\.companyEmail)
            .sink { [weak self] in
                self?.companyEmailHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .mapDistinct(\.streetAddress)
            .sink { [weak self] in
                self?.streetAddressHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .mapDistinct(\.city)
            .sink { [weak self] in
                self?.cityHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .mapDistinct(\.state)
            .sink { [weak self] in
                self?.stateHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .mapDistinct(\.zipCode)
            .sink { [weak self] in
                self?.zipCodeHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .mapDistinct(\.country)
            .sink { [weak self] in
                self?.countryHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .mapDistinct(\.neighbourhood)
            .sink { [weak self] in
                self?.neighbourhoodHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .mapDistinct(\.number)
            .sink { [weak self] in
                self?.numberHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.benefitiaryName)
            .sink { [weak self] in
                self?.benefitiaryNameHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.bankInfo.bankName)
            .sink { [weak self] in
                self?.bankNameHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.bankInfo.iban)
            .sink { [weak self] in
                self?.accountNumberHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.bankInfo.swiftCode)
            .sink { [weak self] in
                self?.swiftCodeHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.bankInfo.bankAddress)
            .sink { [weak self] in
                self?.bankAddressHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.secondaryBankInfo.bankName)
            .sink { [weak self] in
                self?.secondaryBankNameHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.secondaryBankInfo.bankName)
            .sink { [weak self] in
                self?.secondaryBankNameHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.secondaryBankInfo.iban)
            .sink { [weak self] in
                self?.secondaryAccountNumberHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.secondaryBankInfo.swiftCode)
            .sink { [weak self] in
                self?.secondarySwiftCodeHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .map(\.secondaryBankInfo.bankAddress)
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] in
                self?.secondaryBankAddressHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $serviceInfo
            .mapDistinct(\.jobDescription)
            .sink { [weak self] in
                self?.jobDescriptionHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $serviceInfo
            .mapDistinct(\.quantity)
            .sink { [weak self] in
                guard let quantityDoubleValue = Double($0),
                      quantityDoubleValue > 0.0 else {
                    self?.quantityHasError = true
                    return
                }
                
                self?.quantityHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $serviceInfo
            .mapDistinct(\.unitPrice)
            .sink { [weak self] in
                guard let unitPriceDoubleValue = Double($0),
                      unitPriceDoubleValue > 0.0 else {
                    self?.unitPriceHasError = true
                    return
                }
                
                self?.unitPriceHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
    }
    
    private func setUpCTAValidation() {
        Publishers.CombineLatest4(
            $fullNameHasError,
            $taxIdHasError,
            $companyNameHasError,
            $companyEmailHasError
        )
        .map { !$0 && !$1 && !$2 && !$3 }
        .combineLatest($step)
        .map { formsIsValid, step in
            (step == .contractorInfo) ? formsIsValid : false
        }
        .sink { [weak self] in
            guard let self else { return }
            ctaEnabled = $0
        }
        .store(in: &disposeBag)
        
        Publishers.CombineLatest4(
            $streetAddressHasError,
            $numberHasError,
            $neighbourhoodHasError,
            $cityHasError
        )
        .combineLatest(
            $stateHasError,
            $countryHasError,
            $zipCodeHasError
        )
        .map { !$0.0 && !$0.1 && !$0.2 && !$0.3 && !$1 && !$2 && !$3 }
        .combineLatest($step)
        .map { formsIsValid, step in
            (step == .companyAddress) ? formsIsValid : false
        }
        .sink { [weak self] in
            guard let self else { return }
            ctaEnabled = $0
        }
        .store(in: &disposeBag)
        
        $benefitiaryNameHasError
            .combineLatest($bankNameHasError)
            .combineLatest($accountNumberHasError)
            .combineLatest($swiftCodeHasError)
            .combineLatest($bankAddressHasError)
            .combineLatest($shouldShowSecondaryBankForms)
            .combineLatest($secondaryBankNameHasError)
            .combineLatest($secondaryAccountNumberHasError)
            .combineLatest($secondarySwiftCodeHasError)
            .combineLatest($secondaryBankAddressHasError)
            .map {
                let (((((((((beneficiaryHasError, bankNameHasError), accountNumberHasError), swiftCodeHasError), bankAddressHasError), shouldShowSecondaryBankForms), secondaryBankNameHasError), secondaryAccountNumberHasError), secondarySwiftCodeHasError), secondaryBankAddressHasError) = $0
                   
                   let secondaryBankInfoValid = shouldShowSecondaryBankForms ? (
                       !secondaryBankNameHasError &&
                       !secondaryAccountNumberHasError &&
                       !secondarySwiftCodeHasError &&
                       !secondaryBankAddressHasError
                   ) : true
                   
                   return (
                       !beneficiaryHasError &&
                       !bankNameHasError &&
                       !accountNumberHasError &&
                       !swiftCodeHasError &&
                       !bankAddressHasError &&
                       secondaryBankInfoValid
                   )
            }
            .combineLatest($step)
            .map { formsIsValid, step in
                (step == .bankInfo) ? formsIsValid : false
            }
            .sink { [weak self] in
                guard let self else { return }
                ctaEnabled = $0
            }
            .store(in: &disposeBag)
        
        Publishers.CombineLatest3(
            $jobDescriptionHasError,
            $quantityHasError,
            $unitPriceHasError
        )
        .map {
            return !$0 && !$1 && !$2
        }
        .combineLatest($step)
        .map { formsIsValid, step in
            (step == .serviceInfo) ? formsIsValid : false
        }
        .sink { [weak self] in
            guard let self else { return }
            print(jobDescriptionHasError,
                  quantityHasError,
                  unitPriceHasError)
            self.ctaEnabled = $0
        }
        .store(in: &disposeBag)
    }
}
