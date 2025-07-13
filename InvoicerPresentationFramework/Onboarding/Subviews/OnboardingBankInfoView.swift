import SwiftUI
import InvoicerCommonFramework

struct OnboardingBankInfoView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 20,) {
            InputField(
                label: "Benefitiary name",
                placeholder: "Eg: John Johnson",
                text: $viewModel.bankAccountInfo.benefitiaryName,
                errorMessage: viewModel.fieldValidation.benefitiaryNameHasError ? "Benefitiary name is required" : nil
            )
            InputField(
                label: "Account number(IBAN)",
                text: $viewModel.bankAccountInfo.bankInfo.iban,
                errorMessage: viewModel.fieldValidation.accountNumberHasError ? "Bank Account is required" : nil
            )
            InputField(
                label: "Swift code",
                text: $viewModel.bankAccountInfo.bankInfo.swiftCode,
                errorMessage: viewModel.fieldValidation.swiftCodeHasError ? "Swift code is required" : nil
            )
            InputField(
                label: "Bank name",
                text: $viewModel.bankAccountInfo.bankInfo.bankName,
                errorMessage: viewModel.fieldValidation.bankNameHasError ? "Bank name is required" : nil
            )
            InputField(
                label: "Bank address",
                text: $viewModel.bankAccountInfo.bankInfo.bankAddress,
                errorMessage: viewModel.fieldValidation.bankAddressHasError ? "Bank address is required" : nil
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
                    errorMessage: viewModel.fieldValidation.secondaryAccountNumberHasError ? "IBAN is required" : nil
                )
                InputField(
                    label: "Swift code",
                    text: $viewModel.bankAccountInfo.secondaryBankInfo.swiftCode,
                    errorMessage: viewModel.fieldValidation.secondarySwiftCodeHasError ? "Swift code is required" : nil
                )
                InputField(
                    label: "Bank name",
                    text: $viewModel.bankAccountInfo.secondaryBankInfo.bankName,
                    errorMessage: viewModel.fieldValidation.secondaryBankNameHasError ? "Bank name is required" : nil
                )
                InputField(
                    label: "Bank address",
                    text: $viewModel.bankAccountInfo.secondaryBankInfo.bankAddress,
                    errorMessage: viewModel.fieldValidation.secondaryBankAddressHasError ? "Secondary bank address is required" : nil
                )
            }
        }
    }
}

#Preview {
    OnboardingBankInfoView()
        .environmentObject(OnboardingViewModel(coordinator: OnboardingCoordinator()))
        .padding(24)
}
