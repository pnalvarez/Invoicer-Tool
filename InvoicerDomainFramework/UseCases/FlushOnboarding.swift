public protocol FlushOnboardingProtocol {
    func flush() async
}

public final class FlushOnboarding: FlushOnboardingProtocol {
    private let companyRepository: CompanyRepositoryProtocol
    
    public init(companyRepository: CompanyRepositoryProtocol) {
        self.companyRepository = companyRepository
    }
    
    public func flush() async {
        await companyRepository.flushData()
    }
}
