import SwiftUI

struct NewInvoiceFormView: View {
    @ObservedObject var viewModel: NewInvoiceFormViewModel
    @State private var issueDate: String = ""
    @State private var dueDate: String = ""
    @State private var issueDateError: String?
    @State private var dueDateError: String?
    
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
        .modalDialogue(isPresented: $viewModel.shouldDisplayIssueDatePicker) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Select the Issue Date")
                DatePicker(
                        "Start Date",
                        selection: $viewModel.issueDate,
                        displayedComponents: [.date]
                    )
                .datePickerStyle(.graphical)
                .labelsHidden()
            }
        }
        .modalDialogue(isPresented: $viewModel.shouldDisplayDueDatePicker
        ) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Select the Due Date")
                DatePicker(
                        "Start Date",
                        selection: $viewModel.dueDate,
                        displayedComponents: [.date]
                    )
                .datePickerStyle(.graphical)
                .labelsHidden()
            }
        }
        .onChange(of: viewModel.dueDate) { _, value in
            viewModel.shouldDisplayDueDatePicker = false
            dueDate = value.formatted
        }
        .onChange(of: viewModel.issueDate) { _, value in
            viewModel.shouldDisplayIssueDatePicker = false
            issueDate = value.formatted
        }
        .onChange(of: viewModel.state.issueDateError) { _, value in
            issueDateError = value
        }
        .onChange(of: viewModel.state.dueDateError) { _, value in
            dueDateError = value
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
                viewModel.shouldDisplayIssueDatePicker = true
            } label: {
                InputField(
                    label: "Issue Date",
                    text: $issueDate,
                    errorMessage: viewModel.issueDateError,
                    keyboardType: .numberPad,
                    isDisabled: true,
                    needsFocusToShowError: false
                )
            }
            Spacer().frame(height: 16)
            Button {
                viewModel.shouldDisplayDueDatePicker = true
            } label: {
                InputField(
                    label: "Due Date",
                    text: $dueDate,
                    errorMessage: viewModel.dueDateError,
                    keyboardType: .numberPad,
                    isDisabled: true,
                    needsFocusToShowError: false
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
