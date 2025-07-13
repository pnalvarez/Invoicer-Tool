//
//  ContractorInfoWidgetView.swift
//  Invoicer2
//
//  Created by Pedro Alvarez on 30/06/25.
//

import SwiftUI
import InvoicerDomainFramework

struct ContractorInfoWidgetView: View {
    let data: ContractorInfoDomain
    
    var body: some View {
        ZStack {
            Color.black
            Text("\(data.companyName)")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.green)
        }
    }
}

#Preview {
    ContractorInfoWidgetView(data: .init())
}
