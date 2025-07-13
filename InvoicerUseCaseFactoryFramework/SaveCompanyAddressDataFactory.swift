//
//  SaveCompanyAddressDataFactory.swift
//  InvoicerUseCaseFactoryFramework
//
//  Created by Pedro Alvarez on 30/06/25.
//

import InvoicerDomainFramework
import InvoicerDataFramework

public enum SaveCompanyAddressDataFactory {
    public static func make() -> SaveCompanyAddressProtocol {
        SaveCompanyAddress(repository: CompanyRepository())
    }
}
