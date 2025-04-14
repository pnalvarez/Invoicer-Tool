//
//  OnboardingServiceInfoView.swift
//  Invoicer2
//
//  Created by Pedro Alvarez on 08/04/25.
//

import SwiftUI

struct OnboardingServiceInfoView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            InputField(
                label: "Job description",
                placeholder: "E.g: Software development",
                text: $viewModel.serviceInfo.jobDescription
            )
            InputField(
                label: "Quantity",
                placeholder: "E.g: 1.0",
                text: $viewModel.serviceInfo.quantity,
                keyboardType: .decimalPad
            )
            InputField(
                label: "Unit price",
                placeholder: "E.g: 100.00",
                text: $viewModel.serviceInfo.unitPrice,
                keyboardType: .decimalPad
            )
        }
    }
}
