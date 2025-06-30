protocol GetOnboardingStepProtocol {
    func get() -> OnboardingStepDomain
}

final class GetOnboardingStep: GetOnboardingStepProtocol {
    private let repository: OnboardingStepRepositoryProtocol
    
    init(repository: OnboardingStepRepositoryProtocol = OnboardingStepRepository()) {
        self.repository = repository
    }
    
    func get() -> OnboardingStepDomain {
        repository.getCurrentStep()
    }
}
