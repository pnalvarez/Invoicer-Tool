//
//  OnboardingViewModel.swift
//  Invoicer2
//
//  Created by Pedro Alvarez on 04/04/25.
//

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
    
    private var disposeBag: Set<AnyCancellable> = []
    
    private let coordinator: OnboardingCoordinatorProtocol
    
    init(coordinator: OnboardingCoordinatorProtocol) {
        self.coordinator = coordinator
        setUpSubscriptions()
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
        ctaEnabled = false
    }
    
    private func setUpSubscriptions() {
        setUpFieldValidation()
        setUpCTAValidation()
    }
    
    private func setUpFieldValidation() {
        $contractorInfo
            .map(\.fullName)
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] in
                self?.fullNameHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $contractorInfo
            .map(\.cnpj)
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] in
                self?.taxIdHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $contractorInfo
            .map(\.companyName)
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] in
                self?.companyNameHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $contractorInfo
            .map(\.companyEmail)
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] in
                self?.companyEmailHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .map(\.streetAddress)
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] in
                self?.companyEmailHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .map(\.city)
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] in
                self?.cityHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .map(\.state)
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] in
                self?.stateHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .map(\.zipCode)
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] in
                self?.zipCodeHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .map(\.country)
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] in
                self?.countryHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .map(\.neighbourhood)
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] in
                self?.neighbourhoodHasError = $0.isEmpty
            }
            .store(in: &disposeBag)
        
        $companyAddress
            .map(\.number)
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] in
                self?.numberHasError = $0.isEmpty
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
        //        .dropFirst()
        .map { formsIsValid, step in
            (step == .contractorInfo) ? formsIsValid : false
        }
        .sink { [weak self] in self?.ctaEnabled = $0 }
        .store(in: &disposeBag)
    }
}
