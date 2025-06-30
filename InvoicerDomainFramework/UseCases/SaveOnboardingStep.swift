protocol SaveOnboardingStepProtocol {
    func save(_ step: OnboardingStepDomain?)
}

final class SaveOnboardingStep: SaveOnboardingStepProtocol {
    private let repository: OnboardingStepRepositoryProtocol
    
    init(repository: OnboardingStepRepositoryProtocol = OnboardingStepRepository()) {
        self.repository = repository
    }
    
    func save(_ step: OnboardingStepDomain?) {
        repository.saveStep(step: step?.rawValue)
    }
}
