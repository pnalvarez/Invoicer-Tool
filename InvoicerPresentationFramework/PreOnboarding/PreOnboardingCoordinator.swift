import UIKit

protocol PreOnboardingCoordinatorProtocol {
    func navigateToOnboarding(step: OnboardingStepUI)
    func navigateToHome()
}

final class PreOnboardingCoordinator: PreOnboardingCoordinatorProtocol {
    private let onboardingBuilder: OnboardingBuilderProtocol
    private let tabBuilder: TabBuilderProtocol
    weak var viewController: UIViewController?
    
    init(
        onboardingBuilder: OnboardingBuilderProtocol = OnboardingBuilder(),
        tabBuilder: TabBuilderProtocol = TabBuilder()
    ) {
        self.onboardingBuilder = onboardingBuilder
        self.tabBuilder = tabBuilder
    }
    
    func navigateToOnboarding(step: OnboardingStepUI) {
        let onboardingController = onboardingBuilder.build(step: step)
        viewController?.navigationController?.pushViewController(onboardingController, animated: true)
    }
    
    func navigateToHome() {
        let homeController = tabBuilder.build()
        homeController.modalPresentationStyle = .fullScreen
        viewController?.present(homeController, animated: true)
    }
}
