//
//  OnboardingContractorInfoView.swift
//  Invoicer2
//
//  Created by Pedro Alvarez on 08/04/25.
//

import SwiftUI

struct OnboardingContractorInfoView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            InputField(
                label: "Full name",
                placeholder: "Eg: John Johnson",
                text: $viewModel.contractorInfo.fullName,
            )
            InputField(
                label: "Tax ID or CNPJ",
                placeholder: "Eg: 1234567890",
                text: $viewModel.contractorInfo.cnpj,
            )
            InputField(
                label: "Company name",
                placeholder: "Eg: My Company Consultancy Services",
                text: $viewModel.contractorInfo.companyName,
            )
            InputField(
                label: "Company e-mail",
                placeholder: "Eg: company@google.com",
                text: $viewModel.contractorInfo.companyEmail,
            )
        }
    }
}

#Preview {
    OnboardingContractorInfoView()
        .environmentObject(OnboardingViewModel())
        .padding()
}
