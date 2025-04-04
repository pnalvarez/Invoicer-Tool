//
//  PreOnboardingBuilder.swift
//  Invoicer2
//
//  Created by Pedro Alvarez on 04/04/25.
//

import UIKit

protocol PreOnboardingBuilderProtocol {
    func build() -> UIViewController
}

final class PreOnboardingBuilder: PreOnboardingBuilderProtocol {
    func build() -> UIViewController {
        let coordinator = PreOnboardingCoordinator()
        let viewModel = PreOnboardingViewModel(coordinator: coordinator)
        let viewController = PreOnboardingView.getViewController(viewModel: viewModel)
        coordinator.viewController = viewController
        return viewController
    }
}
