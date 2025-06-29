import SwiftUI

protocol OnboardingSuccessCoordinatorProtocol {
    func navigateToHome()
}

final class OnboardingSuccessCoordinator: OnboardingSuccessCoordinatorProtocol {
    weak var viewController: UIViewController?
    private let tabBuilder: TabBuilderProtocol
    
    init(tabBuilder: TabBuilderProtocol = TabBuilder()) {
        self.tabBuilder = tabBuilder
    }
    
    func navigateToHome() {
        let vc = tabBuilder.build()
        vc.modalPresentationStyle = .overFullScreen
        viewController?.present(vc, animated: true)
    }
}
