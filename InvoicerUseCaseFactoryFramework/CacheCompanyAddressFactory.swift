//
//  CacheCompanyAddressFactory.swift
//  InvoicerUseCaseFactoryFramework
//
//  Created by Pedro Alvarez on 30/06/25.
//

import InvoicerDomainFramework
import InvoicerDataFramework

public enum CacheCompanyAddressFactory {
    public static func make() -> CacheCompanyAddressProtocol {
        CacheCompanyAddress(cacheRepository: CacheRepository())
    }
}
