protocol FlushOnboardingProtocol {
    func flush() async
}

final class FlushOnboarding: FlushOnboardingProtocol {
    private let companyRepository: CompanyRepositoryProtocol
    
    init(companyRepository: CompanyRepositoryProtocol = CompanyRepository()) {
        self.companyRepository = companyRepository
    }
    
    func flush() async {
        await companyRepository.flushData()
    }
}
