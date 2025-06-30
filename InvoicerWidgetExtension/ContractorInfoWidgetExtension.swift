//
//  ContractorInfoWidgetExtension.swift
//  InvoicerWidgetExtensionExtension
//
//  Created by Pedro Alvarez on 30/06/25.
//

import WidgetKit
import SwiftUI

@main
struct ContractorInfoWidgetExtension: Widget {
    let kind = "ContractorInfoExtension"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: ContractorInfoEntryTimelineProvider()
        ) { entry in
            ContractorInfoWidgetView(data: entry.data)
        }
        .configurationDisplayName("Contractor Info Extension")
    }
}
