public protocol GetOnboardingStepProtocol {
    func get() -> OnboardingStepDomain
}

public final class GetOnboardingStep: GetOnboardingStepProtocol {
    private let repository: OnboardingStepRepositoryProtocol
    
    public init(repository: OnboardingStepRepositoryProtocol) {
        self.repository = repository
    }
    
    public func get() -> OnboardingStepDomain {
        repository.getCurrentStep()
    }
}
