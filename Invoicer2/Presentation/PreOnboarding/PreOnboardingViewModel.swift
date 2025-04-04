//
//  PreOnboardingViewModel.swift
//  Invoicer2
//
//  Created by Pedro Alvarez on 04/04/25.
//

import Combine

final class PreOnboardingViewModel: ObservableObject {
    private let coordinator: PreOnboardingCoordinatorProtocol
    
    init(coordinator: PreOnboardingCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func didTapCTA() {
        coordinator.navigateToOnboarding()
    }
}
