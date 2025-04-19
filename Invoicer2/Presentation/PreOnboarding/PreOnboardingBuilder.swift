import UIKit

protocol PreOnboardingBuilderProtocol {
    func build() -> UIViewController
}

final class PreOnboardingBuilder: PreOnboardingBuilderProtocol {
    func build() -> UIViewController {
        let onboardingBuilder = OnboardingBuilder()
        let coordinator = PreOnboardingCoordinator(onboardingBuilder: onboardingBuilder)
        let viewModel = PreOnboardingViewModel(coordinator: coordinator)
        let viewController = PreOnboardingView.getViewController(viewModel: viewModel)
        coordinator.viewController = viewController
        return viewController
    }
}
