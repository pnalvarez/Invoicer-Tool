import UIKit

protocol PreOnboardingCoordinatorProtocol {
    func navigateToOnboarding(step: OnboardingStepUI)
}

final class PreOnboardingCoordinator: PreOnboardingCoordinatorProtocol {
    private let onboardingBuilder: OnboardingBuilderProtocol
    weak var viewController: UIViewController?
    
    init(onboardingBuilder: OnboardingBuilderProtocol = OnboardingBuilder()) {
        self.onboardingBuilder = onboardingBuilder
    }
    
    func navigateToOnboarding(step: OnboardingStepUI) {
        let onboardingController = onboardingBuilder.build(step: step)
        viewController?.navigationController?.pushViewController(onboardingController, animated: true)
    }
}
