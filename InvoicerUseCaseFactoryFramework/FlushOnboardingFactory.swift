//
//  FlushOnboardingFactory.swift
//  InvoicerUseCaseFactoryFramework
//
//  Created by Pedro Alvarez on 30/06/25.
//

import InvoicerDomainFramework
import InvoicerDataFramework

public enum FlushOnboardingFactory {
    public static func make() -> FlushOnboardingProtocol {
        FlushOnboarding(companyRepository: CompanyRepository())
    }
}
