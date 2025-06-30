protocol FinishOnboardingProtocol {
    func finish()
}

final class FinishOnboarding: FinishOnboardingProtocol {
    private let repository: OnboardingStepRepositoryProtocol
    
    init(repository: OnboardingStepRepositoryProtocol = OnboardingStepRepository()) {
        self.repository = repository
    }
    
    func finish() {
        repository.saveStep(step: "done")
    }
}

