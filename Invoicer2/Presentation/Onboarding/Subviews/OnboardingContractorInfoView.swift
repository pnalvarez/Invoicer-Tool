import SwiftUI

struct OnboardingContractorInfoView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            InputField(
                label: "Full name",
                placeholder: "Eg: John Johnson",
                text: $viewModel.contractorInfo.fullName,
                errorMessage: viewModel.fullNameHasError ? "Full name is required" : nil,
            )
            InputField(
                label: "Tax ID or CNPJ",
                placeholder: "Eg: 1234567890",
                text: $viewModel.contractorInfo.cnpj,
                errorMessage: viewModel.taxIdHasError ? "Tax ID or CNPJ is required" : nil
            )
            InputField(
                label: "Company name",
                placeholder: "Eg: My Company Consultancy Services",
                text: $viewModel.contractorInfo.companyName,
                errorMessage: viewModel.companyNameHasError ? "Company name is required" : nil
            )
            InputField(
                label: "Company e-mail",
                placeholder: "Eg: company@google.com",
                text: $viewModel.contractorInfo.companyEmail,
                errorMessage: viewModel.companyEmailHasError ? "Company e-mail is required" : nil
            )
        }
    }
}

#Preview {
    OnboardingContractorInfoView()
        .environmentObject(OnboardingViewModel(coordinator: OnboardingCoordinator()))
        .padding()
}
