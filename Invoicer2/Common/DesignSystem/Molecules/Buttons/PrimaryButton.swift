//
//  PrimaryButton.swift
//  Invoicer
//
//  Created by Pedro Alvarez on 31/03/25.
//

import SwiftUI

struct PrimaryButton: View {
    let text: String
    var expandedWidth: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            extraSpacer
            
            Text(text)
                .font(.body)
                .foregroundColor(Color.white)
                .padding(8)
            
            extraSpacer
        })
        .background(Colors.buttonPrimary)
        .cornerRadius(8)
    }
    
    @ViewBuilder
    var extraSpacer: some View {
        if expandedWidth {
            Spacer()
        }
    }
}

#Preview {
    PrimaryButton(text: "Test", expandedWidth: true, action: { })
        .padding()
}
