import Combine

final class OnboardingSuccessViewModel: ObservableObject {
    private let coordinator: OnboardingSuccessCoordinatorProtocol
    let benefitiaryName: String
    
    init(
        benefitiaryName: String,
        coordinator: OnboardingSuccessCoordinatorProtocol
    ) {
        self.benefitiaryName = benefitiaryName
        self.coordinator = coordinator
    }
    
    func didTapCTA() {
        coordinator.navigateToHome()
    }
}
