//
//  CacheBankAccountFactory.swift
//  InvoicerUseCaseFactoryFramework
//
//  Created by Pedro Alvarez on 30/06/25.
//

import InvoicerDomainFramework
import InvoicerDataFramework

public enum CacheBankAccountFactory {
    public static func make() -> CacheBankAccountProtocol {
        CacheBankAccount(cacheRepository: CacheRepository())
    }
}
