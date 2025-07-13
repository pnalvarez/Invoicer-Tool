import UIKit

public protocol PreOnboardingBuilderProtocol {
    func build() -> UIViewController
}

public final class PreOnboardingBuilder: PreOnboardingBuilderProtocol {
    public init() { }
    
    public func build() -> UIViewController {
        let onboardingBuilder = OnboardingBuilder()
        let coordinator = PreOnboardingCoordinator(onboardingBuilder: onboardingBuilder)
        let viewModel = PreOnboardingViewModel(coordinator: coordinator)
        let viewController = PreOnboardingView.getViewController(viewModel: viewModel)
        coordinator.viewController = viewController
        return viewController
    }
}
