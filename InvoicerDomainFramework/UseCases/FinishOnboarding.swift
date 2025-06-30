public protocol FinishOnboardingProtocol {
    func finish()
}

public final class FinishOnboarding: FinishOnboardingProtocol {
    private let repository: OnboardingStepRepositoryProtocol
    
    public init(repository: OnboardingStepRepositoryProtocol) {
        self.repository = repository
    }
    
    public func finish() {
        repository.saveStep(step: "done")
    }
}

