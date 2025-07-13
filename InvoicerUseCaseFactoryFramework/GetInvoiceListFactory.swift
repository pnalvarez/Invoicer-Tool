//
//  GetInvoiceListFactory.swift
//  InvoicerUseCaseFactoryFramework
//
//  Created by Pedro Alvarez on 30/06/25.
//

import InvoicerDomainFramework
import InvoicerDataFramework

public enum GetInvoiceListFactory {
    public static func make() -> GetInvoiceListProtocol {
        GetInvoiceList()
    }
}
