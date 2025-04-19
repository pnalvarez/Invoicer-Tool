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
