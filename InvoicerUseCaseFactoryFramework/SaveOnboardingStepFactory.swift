//
//  SaveOnboardingStepFactory.swift
//  InvoicerUseCaseFactoryFramework
//
//  Created by Pedro Alvarez on 30/06/25.
//

import InvoicerDomainFramework
import InvoicerDataFramework

public enum SaveOnboardingStepFactory {
    public static func make() -> SaveOnboardingStepProtocol {
        SaveOnboardingStep(repository: OnboardingStepRepository())
    }
}
