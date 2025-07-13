//
//  SaveServiceInfoFactory.swift
//  InvoicerUseCaseFactoryFramework
//
//  Created by Pedro Alvarez on 30/06/25.
//

import InvoicerDomainFramework
import InvoicerDataFramework

public enum SaveServiceInfoFactory {
    public static func make() -> SaveServiceInfoProtocol {
        SaveServiceInfo(repository: CompanyRepository())
    }
}
