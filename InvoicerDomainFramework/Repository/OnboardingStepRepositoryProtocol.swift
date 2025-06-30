//
//  OnboardingStepRepositoryProtocol.swift
//  InvoicerDomainFramework
//
//  Created by Pedro Alvarez on 30/06/25.
//

public protocol OnboardingStepRepositoryProtocol {
    func saveStep(step: String?)
    func getCurrentStep() -> OnboardingStepDomain
}
