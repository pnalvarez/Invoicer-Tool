//
//  GetOnboardingStepFactory.swift
//  InvoicerUseCaseFactoryFramework
//
//  Created by Pedro Alvarez on 30/06/25.
//

import InvoicerDomainFramework
import InvoicerDataFramework

public enum GetOnboardingStepFactory {
    public static func make() -> GetOnboardingStepProtocol {
        GetOnboardingStep(repository: OnboardingStepRepository())
    }
}
