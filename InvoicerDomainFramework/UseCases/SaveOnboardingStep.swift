public protocol SaveOnboardingStepProtocol {
    func save(_ step: OnboardingStepDomain?)
}

public final class SaveOnboardingStep: SaveOnboardingStepProtocol {
    private let repository: OnboardingStepRepositoryProtocol
    
    public init(repository: OnboardingStepRepositoryProtocol) {
        self.repository = repository
    }
    
    public func save(_ step: OnboardingStepDomain?) {
        repository.saveStep(step: step?.rawValue)
    }
}
