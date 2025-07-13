import SwiftUI

protocol TabBuilderProtocol {
    func build() -> UIViewController
}

final class TabBuilder: TabBuilderProtocol {
    func build() -> UIViewController {
        let coordinator = TabCoordinator()
        let viewModel = TabViewModel(coordinator: coordinator)
        let viewController = UIHostingController(rootView: TabView(viewModel: viewModel))
        coordinator.viewController = viewController
        return viewController
    }
}
