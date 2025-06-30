import InvoicerDomainFramework

public final class OnboardingStepRepository: OnboardingStepRepositoryProtocol {
    private let cacheDataSource: CacheDataSourceProtocol
    
    public init(cacheDataSource: CacheDataSourceProtocol = CacheDataSource()) {
        self.cacheDataSource = cacheDataSource
    }
    
    public func saveStep(step: String?) {
        cacheDataSource.save("onboardingStep", value: step)
    }
    
    public func getCurrentStep() -> OnboardingStepDomain {
        OnboardingStepDomain(rawValue: cacheDataSource.get("onboardingStep") ?? "") ?? .intro
    }
}
