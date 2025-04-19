import UIKit

protocol OnboardingCoordinatorProtocol {
    func navigateBack()
    func navigateToInvoiceList()
}

class OnboardingCoordinator: OnboardingCoordinatorProtocol {
    weak var viewController: UIViewController?
    
    init() {}
    
    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToInvoiceList() {
        // TO DO
    }
}
