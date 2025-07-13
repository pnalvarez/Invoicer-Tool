//
//  FinishOnboardingFactory.swift
//  InvoicerUseCaseFactoryFramework
//
//  Created by Pedro Alvarez on 30/06/25.
//

import InvoicerDomainFramework
import InvoicerDataFramework

public enum FinishOnboardingFactory {
    public static func make() -> FinishOnboardingProtocol {
        FinishOnboarding(repository: OnboardingStepRepository())
    }
}
