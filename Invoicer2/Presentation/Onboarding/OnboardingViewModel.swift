import Combine
import Observation
import Foundation

final class OnboardingViewModel: ObservableObject {
    private let saveContractorInfo: SaveContractorInfoProtocol
    private let getContractorInfo: GetContractorInfoProtocol
    private let saveCompanyAddress: SaveCompanyAddressProtocol
    private let getCompanyAddress: GetCompanyAddressProtocol
    private let saveBankAccount: SaveBankAccountProtocol
    private let getBankAccount: GetBankAccountProtocol
    private let saveServiceInfo: SaveServiceInfoProtocol
    private let getServiceInfo: GetServiceInfoProtocol
    private let saveOnboardingStep: SaveOnboardingStepProtocol
    
    @Published var contractorInfo: OnboardingContractorInfo = .init()
    @Published var companyAddress: OnboardingCompanyAddress = .init()
    @Published var bankAccountInfo: OnboardingBankAccount = .init()
    @Published var serviceInfo: OnboardingServiceInfo = .init()
    @Published var step: OnboardingStepUI
    
    @Published var shouldShowSecondaryBankForms: Bool = false
    
    var ctaEnabled: Bool = false
    
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
    
    @Published var shouldShowInfoDialog: Bool = false
    
    private var disposeBag: Set<AnyCancellable> = []
    
    private let coordinator: OnboardingCoordinatorProtocol
    
    init(
        saveContractorInfo: SaveContractorInfoProtocol = SaveContractorInfo(),
        getContractorInfo: GetContractorInfoProtocol = GetContractorInfo(),
        saveCompanyAddress: SaveCompanyAddressProtocol = SaveCompanyAddress(),
        getCompanyAddress: GetCompanyAddressProtocol = GetCompanyAddress(),
        saveBankAccount: SaveBankAccountProtocol = SaveBankAccount(),
        getBankAccount: GetBankAccountProtocol = GetBankAccount(),
        saveServiceInfo: SaveServiceInfoProtocol = SaveServiceInfo(),
        getServiceInfo: GetServiceInfoProtocol = GetServiceInfo(),
        saveOnboardingStep: SaveOnboardingStepProtocol = SaveOnboardingStep(),
        step: OnboardingStepUI = .contractorInfo,
        coordinator: OnboardingCoordinatorProtocol
    ) {
        self.saveContractorInfo = saveContractorInfo
        self.getContractorInfo = getContractorInfo
        self.saveCompanyAddress = saveCompanyAddress
        self.getCompanyAddress = getCompanyAddress
        self.saveBankAccount = saveBankAccount
        self.getBankAccount = getBankAccount
        self.saveServiceInfo = saveServiceInfo
        self.getServiceInfo = getServiceInfo
        self.saveOnboardingStep = saveOnboardingStep
        self.step = step
        self.coordinator = coordinator
        setUpSubscriptions()
        restoreOnboardingStep()
    }
    
    func didTapBack() {
        saveOnboardingStep.save(step.previousStep?.toDomainModel())
        guard let previousStep = step.previousStep else {
            coordinator.navigateBack()
            return
        }
        step = previousStep
        Task {
            switch step {
            case .contractorInfo:
                await fillContractorInfoData()
            case .companyAddress:
                await fillCompanyAddressData()
            case .bankInfo:
                await fillBankAccountData()
            case .serviceInfo:
                await fillServiceInfoData()
            default:
                break
            }
        }
        ctaEnabled = true
    }
    
    func didTapInfo() {
        shouldShowInfoDialog = true
    }
    
    func didTapCTA() {
        Task {
            if step.finishesOnboarding {
                saveOnboardingStep.save(.done)
                coordinator.navigateToInvoiceList()
            } else {
                switch step {
                case .contractorInfo:
                    await saveContractorInfo.save(contractorInfo.toDomainModel())
                case .companyAddress:
                    await saveCompanyAddress.save(companyAddress.toDomainModel())
                case .bankInfo:
                    await saveBankAccount.save(bankAccountInfo.toDomainModel())
                case .serviceInfo:
                    await saveServiceInfo.save(serviceInfo.toDomainModel())
                default:
                    break
                }
                await goToNextStep()
            }
        }
    }
    
    func didTapCloseInfoDialog() {
        shouldShowInfoDialog = false
    }
    
    @MainActor
    private func goToNextStep()  {
        if let nextStep = step.nextStep  {
            saveOnboardingStep.save(nextStep.toDomainModel())
            step = nextStep
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
                self?.companyEmailHasError = !$0.isValidEmail
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
    
    private func restoreOnboardingStep() {
        Task {
            switch step {
            case .contractorInfo:
                let domainModel = await getContractorInfo.get()
                saveOnboardingStep.save(.contractorInfo)
                if let domainModel {
                    Task { @MainActor in
                        contractorInfo = .init(domainModel: domainModel)
                    }
                }
            case .companyAddress:
                let domainModel = await getCompanyAddress.get()
                if let domainModel {
                    Task { @MainActor in
                        companyAddress = .init(domainModel: domainModel)
                    }
                }
            case .bankInfo:
                let domainModel = await getBankAccount.get()
                if let domainModel {
                    Task { @MainActor in
                        bankAccountInfo = .init(domainModel: domainModel)
                    }
                }
            case .serviceInfo:
                let domainModel = await getServiceInfo.get()
                if let domainModel {
                    Task { @MainActor in
                        serviceInfo = .init(domainModel: domainModel)
                    }
                }
            default:
                break
            }
        }
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
            self.ctaEnabled = $0
        }
        .store(in: &disposeBag)
    }
    
    private func fillContractorInfoData() async {
        let domainModel = await getContractorInfo.get()
        saveOnboardingStep.save(.contractorInfo)
        if let domainModel {
            Task { @MainActor in
                contractorInfo = .init(domainModel: domainModel)
            }
        }
    }
    
    private func fillCompanyAddressData() async {
        let domainModel = await getCompanyAddress.get()
        saveOnboardingStep.save(.companyAddress)
        if let domainModel {
            Task { @MainActor in
                companyAddress = .init(domainModel: domainModel)
            }
        }
    }
    
    private func fillBankAccountData() async {
        let domainModel = await getBankAccount.get()
        saveOnboardingStep.save(.bankAccount)
        if let domainModel {
            Task { @MainActor in
                bankAccountInfo = .init(domainModel: domainModel)
            }
        }
    }
    
    private func fillServiceInfoData() async {
        let domainModel = await getServiceInfo.get()
        saveOnboardingStep.save(.serviceInfo)
        if let domainModel {
            Task { @MainActor in
                serviceInfo = .init(domainModel: domainModel)
            }
        }
    }
}
