//
//  GetServiceInfoFactory.swift
//  InvoicerUseCaseFactoryFramework
//
//  Created by Pedro Alvarez on 30/06/25.
//

import InvoicerDomainFramework
import InvoicerDataFramework

public enum GetServiceInfoFactory {
    public static func make() -> GetServiceInfoProtocol {
        GetServiceInfo(companyRepository: CompanyRepository(), cacheRepository: CacheRepository())
    }
}
