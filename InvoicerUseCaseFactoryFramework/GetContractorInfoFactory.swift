//
//  GetContractorInfoFactory.swift
//  InvoicerUseCaseFactoryFramework
//
//  Created by Pedro Alvarez on 30/06/25.
//

import InvoicerDomainFramework
import InvoicerDataFramework

public enum GetContractorInfoFactory {
    public static func make() -> GetContractorInfoProtocol {
        GetContractorInfo(
            companyRepository: CompanyRepository(),
            cacheRepository: CacheRepository()
        )
    }
}
