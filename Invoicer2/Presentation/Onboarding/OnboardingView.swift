//
//  OnboardingView.swift
//  Invoicer2
//
//  Created by Pedro Alvarez on 04/04/25.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel = .init()
    
    var body: some View {
        VStack {
            mainContent
                .inMainNavigationView(
                    title: "Onboarding",
                    scrollable: true,
                    leadingItem: .close,
                    trailingView: { Button(action: { }) {
                        Image(systemName: "info.circle")
                    }
                    }
                )
            
            Spacer()
            
            PrimaryButton(
                text: "Save",
                expandedWidth: true,
                action: {}
            )
            .padding(.bottom, 32)
            .padding(.horizontal, 20)
               
        }
        .environmentObject(viewModel)
        .ignoresSafeArea(edges: .bottom)
    }
    
    private var mainContent: some View {
        VStack(spacing: .zero) {
            Text(viewModel.step?.title ?? "")
                .font(.headline)
                .foregroundColor(Colors.textPrimary)
            
            Spacer().frame(height: 16)
            
            Text(viewModel.step?.description ?? "")
                .font(.body)
                .foregroundColor(Colors.textPrimary)
                .multilineTextAlignment(.center)
            
            Spacer().frame(height: 40)
            
            switch viewModel.step {
            case .contractorInfo:
                OnboardingContractorInfoView()
            case .companyAddress:
                OnboardingCompanyAddressView()
            case .bankInfo:
                OnboardingBankInfoView()
            case .serviceInfo:
                OnboardingServiceInfoView()
            case .none:
                EmptyView()
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 20)
    }
}

#Preview {
    OnboardingView()
}
