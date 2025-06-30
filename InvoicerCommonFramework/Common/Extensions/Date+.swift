//
//  Date+.swift
//  Invoicer2
//
//  Created by Pedro Alvarez on 09/06/25.
//

import Foundation

public extension Date {
    var formatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}
