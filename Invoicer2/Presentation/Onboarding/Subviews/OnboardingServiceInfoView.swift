import SwiftUI

struct OnboardingServiceInfoView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            InputField(
                label: "Job description",
                placeholder: "E.g: Software development",
                text: $viewModel.serviceInfo.jobDescription,
                errorMessage: viewModel.fieldValidation.jobDescriptionHasError ? "Job Description is required" : nil,
            )
            HStack(alignment: .top) {
                InputField(
                    label: "Quantity",
                    placeholder: "E.g: 1.0",
                    text: $viewModel.serviceInfo.quantity,
                    errorMessage: viewModel.fieldValidation.quantityHasError ? "Quantity should be valid and greater than zero" : nil,
                    keyboardType: .decimalPad,
                )
                InputField(
                    label: "Unit price",
                    placeholder: "E.g: 100.00",
                    text: $viewModel.serviceInfo.unitPrice,
                    errorMessage: viewModel.fieldValidation.unitPriceHasError ? "Unit price should be valid and greater than zero" : nil,
                    keyboardType: .decimalPad,
                )
            }
        }
    }
}
