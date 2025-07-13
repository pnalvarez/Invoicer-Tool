//
//  GetCompanyAddressFactory.swift
//  InvoicerUseCaseFactoryFramework
//
//  Created by Pedro Alvarez on 30/06/25.
//

import InvoicerDomainFramework
import InvoicerDataFramework

public enum GetCompanyAddressFactory {
    public static func make() -> GetCompanyAddressProtocol {
        GetCompanyAddress(
            companyRepository: CompanyRepository(),
            cacheRepository: CacheRepository()
        )
    }
}
