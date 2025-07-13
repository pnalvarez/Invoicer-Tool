//
//  CacheContractorInfoFactory.swift
//  InvoicerUseCaseFactoryFramework
//
//  Created by Pedro Alvarez on 30/06/25.
//

import InvoicerDomainFramework
import InvoicerDataFramework

public enum CacheContractorInfoFactory {
    public static func make() -> CacheContractorInfoProtocol {
        CacheContractorInfo(cacheRepository: CacheRepository())
    }
}
