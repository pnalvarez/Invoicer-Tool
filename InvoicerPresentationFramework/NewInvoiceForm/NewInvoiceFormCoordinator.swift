import SwiftUI

protocol NewInvoiceFormCoordinatorProtocol {
    func navigateBack()
}

final class NewInvoiceFormCoordinator: NewInvoiceFormCoordinatorProtocol {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        _path = path
    }
    
    func navigateBack() {
        path.removeLast()
    }
}
