import SwiftUI

protocol NewInvoiceFormBuilderProtocol {
    func build(path: Binding<NavigationPath>) -> NewInvoiceFormView
}

final class NewInvoiceFormBuilder: NewInvoiceFormBuilderProtocol {
    func build(path: Binding<NavigationPath>) -> NewInvoiceFormView {
        NewInvoiceFormView(
            viewModel: NewInvoiceFormViewModel(
                coordinator: NewInvoiceFormCoordinator(path: path)
            )
        )
    }
}
