import UIKit

protocol PreOnboardingCoordinatorProtocol {
    func navigateToOnboarding()
}

final class PreOnboardingCoordinator: PreOnboardingCoordinatorProtocol {
    private let onboardingBuilder: OnboardingBuilderProtocol
    weak var viewController: UIViewController?
    
    init(onboardingBuilder: OnboardingBuilderProtocol = OnboardingBuilder()) {
        self.onboardingBuilder = onboardingBuilder
    }
    
    func navigateToOnboarding() {
        let onboardingController = onboardingBuilder.build()
        viewController?.navigationController?.pushViewController(onboardingController, animated: true)
    }
}
