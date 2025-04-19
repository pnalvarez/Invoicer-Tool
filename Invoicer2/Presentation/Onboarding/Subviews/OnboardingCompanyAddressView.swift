import SwiftUI

struct OnboardingCompanyAddressView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 16) {
            GridRow(alignment: .top) {
                InputField(
                    label: "Street Address",
                    placeholder: "Eg: St Patrick Street",
                    text: $viewModel.companyAddress.streetAddress,
                    errorMessage: viewModel.streetAddressHasError ? "Street address is required" : nil
                )
                .gridCellColumns(3)
                
                InputField(
                    label: "Number",
                    text: $viewModel.companyAddress.number,
                    errorMessage: viewModel.numberHasError ? "Number is required" : nil
                )
            }
            
            GridRow(alignment: .top) {
                InputField(
                    label: "Neighbourhood",
                    placeholder: "Eg: Manhattan",
                    text: $viewModel.companyAddress.neighbourhood,
                    errorMessage: viewModel.neighbourhoodHasError ? "Neighbourhood is required" : nil
                )
                .gridCellColumns(4)
            }
            
            GridRow(alignment: .top) {
                InputField(
                    label: "City",
                    placeholder: "Eg: São Paulo",
                    text: $viewModel.companyAddress.city,
                    errorMessage: viewModel.cityHasError ? "City is required" : nil
                )
                .gridCellColumns(2)
                
                
                InputField(
                    label: "State",
                    text: $viewModel.companyAddress.state,
                    errorMessage: viewModel.stateHasError ? "State is required" : nil
                )
                
                
                InputField(
                    label: "Country",
                    text: $viewModel.companyAddress.country,
                    errorMessage: viewModel.countryHasError ? "Country is required" : nil
                )
            }
            
            GridRow(alignment: .top) {
                InputField(
                    label: "Zip Code",
                    text: $viewModel.companyAddress.zipCode,
                    errorMessage: viewModel.zipCodeHasError ? "Zip Code is required" : nil
                )
                .gridCellColumns(4)
            }
        }
    }
}

#Preview {
    OnboardingCompanyAddressView()
        .environmentObject(OnboardingViewModel(coordinator: OnboardingCoordinator()))
        .padding()
}
