import SwiftUI

protocol InvoiceListCoordinatorProtocol {
    func navigateToNewInvoiceForms()
}

final class InvoiceListCoordinator: InvoiceListCoordinatorProtocol {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        _path = path
    }
    
    func navigateBack() {
        path.removeLast(2)
    }
    
    func navigateToNewInvoiceForms() {
        path.append(TabRoute.newInvoice)
    }
}


