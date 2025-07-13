//
//  SaveBankAccountUseCaseFactory.swift
//  InvoicerUseCaseFactoryFramework
//
//  Created by Pedro Alvarez on 30/06/25.
//

import InvoicerDomainFramework
import InvoicerDataFramework

public enum SaveBankAccountUseCaseFactory {
    public static func make() -> SaveBankAccountProtocol {
        SaveBankAccount(repository: CompanyRepository())
    }
}
