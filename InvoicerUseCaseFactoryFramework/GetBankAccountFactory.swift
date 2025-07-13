//
//  GetBankAccountFactory.swift
//  InvoicerUseCaseFactoryFramework
//
//  Created by Pedro Alvarez on 30/06/25.
//

import InvoicerDomainFramework
import InvoicerDataFramework

public enum GetBankAccountFactory {
    public static func make() -> GetBankAccountProtocol {
        GetBankAccount(
            companyRepository: CompanyRepository(),
            cacheRepository: CacheRepository()
        )
    }
}
