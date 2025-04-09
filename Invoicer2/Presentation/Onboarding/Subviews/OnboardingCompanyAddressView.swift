//
//  OnboardingCompanyAddressView.swift
//  Invoicer2
//
//  Created by Pedro Alvarez on 08/04/25.
//

import SwiftUI

struct OnboardingCompanyAddressView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
            GeometryReader { geometry in
                VStack(spacing: 24) {
                    HStack {
                        InputField(
                            label: "Street Address",
                            placeholder: "Eg: St Patrict Street.",
                            text: $viewModel.companyAddress.streetAddress,
                        )
                        .frame(width: geometry.size.width * 0.75)
                        
                        InputField(
                            label: "Apt/Number",
                            text: $viewModel.companyAddress.number,
                        )
                        .frame(width: geometry.size.width * 0.25)
                    }
                    
                    InputField(
                        label: "Neighbourhood",
                        placeholder: "Eg: Mangathan",
                        text: $viewModel.companyAddress.streetAddress,
                    )
                    .frame(width: .infinity)
                    
                    HStack {
                        InputField(
                            label: "City",
                            placeholder: "Eg: São Paulo",
                            text: $viewModel.companyAddress.city,
                        )
                        .frame(width: geometry.size.width * 0.5)
                        
                        InputField(
                            label: "State",
                            text: $viewModel.companyAddress.state,
                        )
                        .frame(width: geometry.size.width * 0.2)
                        
                        InputField(
                            label: "Country",
                            text: $viewModel.companyAddress.country,
                        )
                        .frame(width: geometry.size.width * 0.2)
                    }
                    InputField(
                        label: "Zip Code",
                        text: $viewModel.companyAddress.streetAddress,
                    )
                    .frame(width: .infinity)
                }
            }
        }
}

#Preview {
    OnboardingCompanyAddressView()
        .environmentObject(OnboardingViewModel())
}
