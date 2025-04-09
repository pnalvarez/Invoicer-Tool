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
}

final class OnboardingViewModel: ObservableObject {
    @Published var contractorInfo: OnboardingContractorInfo = .init()
    @Published var companyAddress: OnboardingCompanyAddress = .init()
    @Published var bankAccountInfo: OnboardingBankAccount = .init()
    @Published var serviceInfo: OnboardingServiceInfo = .init()
    @Published var step: OnboardingStep? = .contractorInfo
    @Published var shouldShowSecondaryBankForms: Bool = false
    
    func goToNextStep() {
        step = step?.nextStep
    }
}
