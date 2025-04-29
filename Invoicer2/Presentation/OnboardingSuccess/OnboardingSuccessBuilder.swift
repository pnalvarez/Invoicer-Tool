import UIKit

protocol OnboardingSuccessBuilderProtocol {
    func build(benefitiaryName: String) -> UIViewController
}

final class OnboardingSuccessBuilder: OnboardingSuccessBuilderProtocol {
    func build(benefitiaryName: String) -> UIViewController {
        let coordinator = OnboardingSuccessCoordinator()
        let viewModel = OnboardingSuccessViewModel(benefitiaryName: benefitiaryName, coordinator: coordinator)
        let viewController = OnboardingSuccessView.getViewController(viewModel: viewModel)
        coordinator.viewController = viewController
        return viewController
    }
}
