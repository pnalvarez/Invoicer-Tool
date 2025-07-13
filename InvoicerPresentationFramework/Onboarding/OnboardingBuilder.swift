import SwiftUI

protocol OnboardingBuilderProtocol {
    func build(step: OnboardingStepUI) -> UIViewController
}

final class OnboardingBuilder: OnboardingBuilderProtocol {
    func build(step: OnboardingStepUI) -> UIViewController {
        let coordinator = OnboardingCoordinator()
        let viewModel = OnboardingViewModel(step: step, coordinator: coordinator)
        let viewController = UIHostingController(rootView: OnboardingView(viewModel: viewModel))
        coordinator.viewController = viewController
        return viewController
    }
}
