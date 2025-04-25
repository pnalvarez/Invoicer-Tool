protocol OnboardingStepRepositoryProtocol {
    func saveStep(step: String?)
    func getCurrentStep() -> OnboardingStepDomain
}

final class OnboardingStepRepository: OnboardingStepRepositoryProtocol {
    private let cacheDataSource: CacheDataSourceProtocol
    
    init(cacheDataSource: CacheDataSourceProtocol = CacheDataSource()) {
        self.cacheDataSource = cacheDataSource
    }
    
    func saveStep(step: String?) {
        cacheDataSource.save("onboardingStep", value: step)
    }
    
    func getCurrentStep() -> OnboardingStepDomain {
        OnboardingStepDomain(rawValue: cacheDataSource.get("onboardingStep") ?? "") ?? .intro
    }
}
