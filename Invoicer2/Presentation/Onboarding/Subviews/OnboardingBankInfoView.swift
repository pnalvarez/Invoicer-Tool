//
//  OnboardingBankInfoView.swift
//  Invoicer2
//
//  Created by Pedro Alvarez on 08/04/25.
//

import SwiftUI

struct OnboardingBankInfoView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 20,) {
            InputField(
                label: "Benefitiary name",
                placeholder: "Eg: John Johnson",
                text: $viewModel.bankAccountInfo.benefitiaryName,
            )
            InputField(
                label: "Account number(IBAN)",
                text: $viewModel.bankAccountInfo.bankInfo.iban,
            )
            InputField(
                label: "Swift code",
                text: $viewModel.bankAccountInfo.bankInfo.swiftCode,
            )
            InputField(
                label: "Bank name",
                text: $viewModel.bankAccountInfo.bankInfo.bankName,
            )
            InputField(
                label: "Bank address",
                text: $viewModel.bankAccountInfo.bankInfo.bankAddress,
            )
            
            HStack {
                Text("Intermediary bank(optional)")
                    .font(.caption)
                Spacer()
                Toggle("", isOn: $viewModel.shouldShowSecondaryBankForms)
                    .tint(Colors.buttonPrimary)
            }
            
            if viewModel.shouldShowSecondaryBankForms {
                InputField(
                    label: "Account number(IBAN)",
                    text: $viewModel.bankAccountInfo.secondaryBankInfo.iban,
                )
                InputField(
                    label: "Swift code",
                    text: $viewModel.bankAccountInfo.secondaryBankInfo.swiftCode,
                )
                InputField(
                    label: "Bank name",
                    text: $viewModel.bankAccountInfo.secondaryBankInfo.bankName,
                )
                InputField(
                    label: "Bank address",
                    text: $viewModel.bankAccountInfo.bankInfo.bankAddress,
                )
            }
        }
    }
}

#Preview {
    OnboardingBankInfoView()
        .environmentObject(OnboardingViewModel())
        .padding(24)
}
