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
    case billingInfo
    
    var nextStep: OnboardingStep? {
        switch self {
        case .contractorInfo:
            return .companyAddress
        case .companyAddress:
            return .bankInfo
        case .bankInfo:
            return .billingInfo
        case .billingInfo:
            return nil
        }
    }
}

final class OnboardingViewModel: ObservableObject {
    @Published var companyName: String = ""
    @Published var bankName: String = ""
    @Published var step: OnboardingStep? = .contractorInfo
    
    func goToNextStep() {
        step = step?.nextStep
    }
}
