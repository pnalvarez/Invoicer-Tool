import UIKit

protocol OnboardingCoordinatorProtocol {
    func navigateBack()
    func navigateToOnboardingSuccess(benefitiaryName: String)
}

class OnboardingCoordinator: OnboardingCoordinatorProtocol {
    private let onboardingSuccessBuilder: OnboardingSuccessBuilderProtocol
    weak var viewController: UIViewController?
    
    init(onboardingSuccessBuilder: OnboardingSuccessBuilderProtocol = OnboardingSuccessBuilder()) {
        self.onboardingSuccessBuilder = onboardingSuccessBuilder
    }
    
    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToOnboardingSuccess(benefitiaryName: String) {
        let onboardingSuccessViewController = onboardingSuccessBuilder.build(benefitiaryName: benefitiaryName)
        viewController?.navigationController?.pushViewController(onboardingSuccessViewController, animated: true)
    }
}
