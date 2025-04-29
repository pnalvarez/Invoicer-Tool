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
    private let cacheContractorInfo: CacheContractorInfoProtocol
    private let cacheCompanyAddress: CacheCompanyAddressProtocol
    private let cacheBankAccount: CacheBankAccountProtocol
    private let cacheServiceInfo: CacheServiceInfoProtocol
    private let cleanCache: CleanCacheProtocol
    
    @Published var contractorInfo: OnboardingContractorInfo = .init()
    @Published var companyAddress: OnboardingCompanyAddress = .init()
    @Published var bankAccountInfo: OnboardingBankAccount = .init()
    @Published var serviceInfo: OnboardingServiceInfo = .init()
    @Published var step: OnboardingStepUI
    @Published var shouldShowSecondaryBankForms: Bool = false
    @Published var ctaEnabled: Bool = false
    @Published var shouldShowInfoDialog: Bool = false
    @Published var fieldValidation: OnboardingFieldValidation = .init()
    
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
        cacheContractorInfo: CacheContractorInfoProtocol = CacheContractorInfo(),
        cacheCompanyAddress: CacheCompanyAddressProtocol = CacheCompanyAddress(),
        cacheBankAccount: CacheBankAccountProtocol = CacheBankAccount(),
        cacheServiceInfo: CacheServiceInfoProtocol = CacheServiceInfo(),
        cleanCache: CleanCacheProtocol = CleanCache(),
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
        self.cacheContractorInfo = cacheContractorInfo
        self.cacheCompanyAddress = cacheCompanyAddress
        self.cacheBankAccount = cacheBankAccount
        self.cacheServiceInfo = cacheServiceInfo
        self.saveOnboardingStep = saveOnboardingStep
        self.cleanCache = cleanCache
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
                let benefitiaryName = bankAccountInfo.benefitiaryName
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    coordinator.navigateToOnboardingSuccess(benefitiaryName: benefitiaryName)
                }
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
                self?.fieldValidation.fullNameHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $contractorInfo
            .mapDistinct(\.cnpj)
            .sink { [weak self] in
                self?.fieldValidation.taxIdHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $contractorInfo
            .mapDistinct(\.companyName)
            .sink { [weak self] in
                self?.fieldValidation.companyNameHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $contractorInfo
            .mapDistinct(\.companyEmail)
            .sink { [weak self] in
                self?.fieldValidation.companyEmailHasError = !$0.isValidEmail
            }
            .store(in: &disposeBag)
        
        $contractorInfo
            .dropFirst()
            .sink { [weak self] in
                guard let self else { return }
                cacheContractorInfo.cache($0.toDomainModel())
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .mapDistinct(\.streetAddress)
            .sink { [weak self] in
                self?.fieldValidation.streetAddressHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .mapDistinct(\.city)
            .sink { [weak self] in
                self?.fieldValidation.cityHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .mapDistinct(\.state)
            .sink { [weak self] in
                self?.fieldValidation.stateHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .mapDistinct(\.zipCode)
            .sink { [weak self] in
                self?.fieldValidation.zipCodeHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .mapDistinct(\.country)
            .sink { [weak self] in
                self?.fieldValidation.countryHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .mapDistinct(\.neighbourhood)
            .sink { [weak self] in
                self?.fieldValidation.neighbourhoodHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .mapDistinct(\.number)
            .sink { [weak self] in
                self?.fieldValidation.numberHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .dropFirst()
            .sink { [weak self] in
                guard let self else { return }
                cacheCompanyAddress.cache($0.toDomainModel())
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.benefitiaryName)
            .sink { [weak self] in
                self?.fieldValidation.benefitiaryNameHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.bankInfo.bankName)
            .sink { [weak self] in
                self?.fieldValidation.bankNameHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.bankInfo.iban)
            .sink { [weak self] in
                self?.fieldValidation.accountNumberHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.bankInfo.swiftCode)
            .sink { [weak self] in
                self?.fieldValidation.swiftCodeHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.bankInfo.bankAddress)
            .sink { [weak self] in
                self?.fieldValidation.bankAddressHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.secondaryBankInfo.bankName)
            .sink { [weak self] in
                self?.fieldValidation.secondaryBankNameHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.secondaryBankInfo.bankName)
            .sink { [weak self] in
                self?.fieldValidation.secondaryBankNameHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.secondaryBankInfo.iban)
            .sink { [weak self] in
                self?.fieldValidation.secondaryAccountNumberHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .mapDistinct(\.secondaryBankInfo.swiftCode)
            .sink { [weak self] in
                self?.fieldValidation.secondarySwiftCodeHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .dropFirst()
            .sink { [weak self] in
                guard let self else { return }
                cacheBankAccount.cache($0.toDomainModel())
            }
            .store(in: &disposeBag)
        
        $bankAccountInfo
            .map(\.secondaryBankInfo.bankAddress)
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] in
                self?.fieldValidation.secondaryBankAddressHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $serviceInfo
            .mapDistinct(\.jobDescription)
            .sink { [weak self] in
                self?.fieldValidation.jobDescriptionHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $serviceInfo
            .mapDistinct(\.quantity)
            .sink { [weak self] in
                guard let quantityDoubleValue = Double($0),
                      quantityDoubleValue > 0.0 else {
                    self?.fieldValidation.quantityHasError = true
                    return
                }
                
                self?.fieldValidation.quantityHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $serviceInfo
            .mapDistinct(\.unitPrice)
            .sink { [weak self] in
                guard let unitPriceDoubleValue = Double($0),
                      unitPriceDoubleValue > 0.0 else {
                    self?.fieldValidation.unitPriceHasError = true
                    return
                }
                
                self?.fieldValidation.unitPriceHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $serviceInfo
            .dropFirst()
            .sink { [weak self] in
                guard let self else { return }
                cacheServiceInfo.cache($0.toDomainModel())
            }
            .store(in: &disposeBag)
        
        $step
            .dropFirst()
            .sink { [weak self] _ in
                guard let self else { return }
                cleanCache.clean()
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
            $fieldValidation.mapDistinct(\.fullNameHasError),
            $fieldValidation.mapDistinct(\.taxIdHasError),
            $fieldValidation.mapDistinct(\.companyNameHasError),
            $fieldValidation.mapDistinct(\.companyEmailHasError)
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
            $fieldValidation.mapDistinct(\.streetAddressHasError),
            $fieldValidation.mapDistinct(\.numberHasError),
            $fieldValidation.mapDistinct(\.neighbourhoodHasError),
            $fieldValidation.mapDistinct(\.cityHasError)
        )
        .combineLatest(
            $fieldValidation.mapDistinct(\.stateHasError),
            $fieldValidation.mapDistinct(\.countryHasError),
            $fieldValidation.mapDistinct(\.zipCodeHasError),
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
        
        $fieldValidation.mapDistinct(\.benefitiaryNameHasError)
            .combineLatest($fieldValidation.mapDistinct(\.bankNameHasError))
            .combineLatest($fieldValidation.mapDistinct(\.accountNumberHasError))
            .combineLatest($fieldValidation.mapDistinct(\.swiftCodeHasError))
            .combineLatest($fieldValidation.mapDistinct(\.bankAddressHasError))
            .combineLatest($shouldShowSecondaryBankForms)
            .combineLatest(
                $fieldValidation.mapDistinct(
                    \.secondaryBankNameHasError,
                     removeDuplicates: false
                )
            )
            .combineLatest(
                $fieldValidation.mapDistinct(
                    \.secondaryAccountNumberHasError,
                     removeDuplicates: false
                )
            )
            .combineLatest(
                $fieldValidation.mapDistinct(
                    \.secondarySwiftCodeHasError,
                     removeDuplicates: false
                )
            )
            .combineLatest(
                $fieldValidation.mapDistinct(
                    \.secondaryBankAddressHasError,
                     removeDuplicates: false
                )
            )
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
            $fieldValidation.mapDistinct(\.jobDescriptionHasError),
            $fieldValidation.mapDistinct(\.quantityHasError),
            $fieldValidation.mapDistinct(\.unitPriceHasError)
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
