import SwiftUI

protocol OnboardingBuilderProtocol {
    func build() -> UIViewController
}

final class OnboardingBuilder: OnboardingBuilderProtocol {
    func build() -> UIViewController {
        let coordinator = OnboardingCoordinator()
        let viewModel = OnboardingViewModel(coordinator: coordinator)
        let viewController = UIHostingController(rootView: OnboardingView(viewModel: viewModel))
        coordinator.viewController = viewController
        return viewController
    }
}
