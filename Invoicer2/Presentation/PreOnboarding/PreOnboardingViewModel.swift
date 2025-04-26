import Combine

final class PreOnboardingViewModel: ObservableObject {
    private let saveOnboardingStep: SaveOnboardingStepProtocol
    private let getOnboardingStep: GetOnboardingStepProtocol
    private let flushOnboarding: FlushOnboardingProtocol
    private let coordinator: PreOnboardingCoordinatorProtocol
    
    @Published var shouldShowOnboardingReminderDialog: Bool = false
    @Published var onboardingStep: OnboardingStepUI?
    
    init(
        saveOnboardingStep: SaveOnboardingStepProtocol = SaveOnboardingStep(),
        getOnboardingStep: GetOnboardingStepProtocol = GetOnboardingStep(),
        flushOnboarding: FlushOnboardingProtocol = FlushOnboarding(),
        coordinator: PreOnboardingCoordinatorProtocol
    ) {
        self.saveOnboardingStep = saveOnboardingStep
        self.getOnboardingStep = getOnboardingStep
        self.flushOnboarding = flushOnboarding
        self.coordinator = coordinator
    }
    
    func didTapTapToResumeOnboarding() {
        shouldShowOnboardingReminderDialog = false
        coordinator.navigateToOnboarding(step: onboardingStep ?? .contractorInfo)
    }
    
    func didTapCTA() {
        coordinator.navigateToOnboarding(step: .contractorInfo)
    }
    
    func didTapRestartOnboarding() {
        shouldShowOnboardingReminderDialog = false
        Task {
            await flushOnboarding.flush()
            saveOnboardingStep.save(nil)
        }
    }
    
    func onAppear() {
        checkOnboardingStep()
    }
    
    private func checkOnboardingStep() {
        onboardingStep = OnboardingStepUI.fromDomainModel(getOnboardingStep.get())
        if onboardingStep != .done && onboardingStep != .intro {
            shouldShowOnboardingReminderDialog = true
        }
    }
}
