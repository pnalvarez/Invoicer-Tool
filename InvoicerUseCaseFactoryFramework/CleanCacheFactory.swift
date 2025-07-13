//
//  CleanCacheFactory.swift
//  InvoicerUseCaseFactoryFramework
//
//  Created by Pedro Alvarez on 30/06/25.
//

import InvoicerDomainFramework
import InvoicerDataFramework

public enum CleanCacheFactory {
    public static func make() -> CleanCacheProtocol {
        CleanCache(cacheRepository: CacheRepository())
    }
}
