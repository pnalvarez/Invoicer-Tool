import SwiftUI

protocol InvoiceListBuilderProtocol {
    func build(path: Binding<NavigationPath>) -> InvoiceListView
}

final class InvoiceListBuilder: InvoiceListBuilderProtocol {
    func build(path: Binding<NavigationPath>) -> InvoiceListView {
        InvoiceListView(viewModel: InvoiceListViewModel(coordinator: InvoiceListCoordinator(path: path)))
    }
}
