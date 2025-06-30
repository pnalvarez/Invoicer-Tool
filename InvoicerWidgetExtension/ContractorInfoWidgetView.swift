//
//  ContractorInfoWidgetView.swift
//  Invoicer2
//
//  Created by Pedro Alvarez on 30/06/25.
//

import SwiftUI
import Invoicer2

struct ContractorInfoWidgetView: View {
    let data: ContractorInfoDomain
    
    var body: some View {
        VStack {
            HStack {
                Text("Contractor Name")
                    .font(.headline)
                Spacer()
                Text(data.fullName)
            }
            
            spacing
            
            HStack {
                Text("Contractor Company Name")
                    .font(.headline)
                Spacer()
                Text(data.companyName)
            }
            
            spacing
            
            HStack {
                Text("Company Email")
                    .font(.headline)
                Spacer()
                Text(data.companyEmail)
            }
            
            spacing
            
            HStack {
                Text("CNPJ")
                    .font(.headline)
                Spacer()
                Text(data.cnpj)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue)
        )
    }
    
    private var spacing: some View {
        VStack(spacing: .zero) {
            Spacer().frame(height: 8)
            
            Divider()
                .background(Color.gray)
                .frame(height: 0.5)
            
            Spacer().frame(height: 8)
        }
    }
}
