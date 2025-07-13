//
//  MainWidgetBundle.swift
//  InvoicerWidgetExtensionExtension
//
//  Created by Pedro Alvarez on 01/07/25.
//

import WidgetKit
import SwiftUI

@main
struct WidgetExtensionBundle: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        WidgetBundleBuilder.buildBlock(ContractorInfoWidget())
    }
}
