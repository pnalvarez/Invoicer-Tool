import SwiftUI

struct NewInvoiceFormView: View {
    @ObservedObject var viewModel: NewInvoiceFormViewModel
    @State private var date = Date()
    
    var body: some View {
        VStack {
            mainContent
                .inMainNavigationView(
                    title: "New Invoice",
                    leadingItem: .backArrow,
                    leadingAction: viewModel.didTapBack
                )
            Spacer()
            PrimaryButton(
                text: "Save Invoice",
                enabled: viewModel.state.ctaEnabled, expandedWidth: true,
                action: { }
            )
            .padding(.bottom, 32)
            .padding(.horizontal, 20)
        }
        .modalDialogue(isPresented: $viewModel.state.shouldDisplayIssueDatePicker) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Select the Issue Date")
                DatePicker(
                        "Start Date",
                        selection: $viewModel.state.issueDate,
                        displayedComponents: [.date]
                    )
                .datePickerStyle(.graphical)
                .labelsHidden()
            }
            .onChange(of: viewModel.state.issueDate) {
                viewModel.state.shouldDisplayIssueDatePicker = false
            }
        }
        .modalDialogue(isPresented: $viewModel.state.shouldDisplayDueDatePicker
        ) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Select the Due Date")
                DatePicker(
                        "Start Date",
                        selection: $viewModel.state.dueDate,
                        displayedComponents: [.date]
                    )
                .datePickerStyle(.graphical)
                .labelsHidden()
            }
            .onChange(of: viewModel.state.dueDate) {
                viewModel.state.shouldDisplayDueDatePicker = false
            }
        }
    }
    
    private var mainContent: some View {
        VStack(
            alignment: .leading,
            spacing: .zero
        ) {
            Spacer().frame(height: 20)
            Text("Fill in the form with information about your invoice")
            Spacer().frame(height: 32)
            InputField(
                label: "Invoice ID",
                text: $viewModel.state.invoiceId,
                errorMessage: viewModel.state.invoiceIdError,
                keyboardType: .numberPad)
            Spacer().frame(height: 16)
            Button {
                viewModel.state.shouldDisplayIssueDatePicker = true
            } label: {
                InputField(
                    label: "Issue Date",
                    text: .constant(viewModel.state.issueDateWasSelected ? viewModel.state.issueDate.formatted : ""),
                    errorMessage: viewModel.state.issueDateError,
                    keyboardType: .numberPad,
                    isDisabled: true
                )
            }
            Spacer().frame(height: 16)
            Button {
                viewModel.state.shouldDisplayDueDatePicker = true
            } label: {
                InputField(
                    label: "Due Date",
                    text: .constant(viewModel.state.dueDateWasSelected ? viewModel.state.dueDate.formatted : ""),
                    errorMessage: viewModel.state.dueDateError,
                    keyboardType: .numberPad,
                    isDisabled: true
                )
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    NewInvoiceFormBuilder()
        .build(path: .constant(NavigationPath()))
}
