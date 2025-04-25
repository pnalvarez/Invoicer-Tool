import Combine

final class PreOnboardingViewModel: ObservableObject {
    private let saveOnboardingStep: SaveOnboardingStepProtocol
    private let getOnboardingStep: GetOnboardingStepProtocol
    private let coordinator: PreOnboardingCoordinatorProtocol
    
    @Published var shouldShowOnboardingReminderDialog: Bool = false
    @Published var onboardingStep: OnboardingStepUI?
    
    init(
        saveOnboardingStep: SaveOnboardingStepProtocol = SaveOnboardingStep(),
        getOnboardingStep: GetOnboardingStepProtocol = GetOnboardingStep(),
        coordinator: PreOnboardingCoordinatorProtocol
    ) {
        self.saveOnboardingStep = saveOnboardingStep
        self.getOnboardingStep = getOnboardingStep
        self.coordinator = coordinator
    }
    
    func didTapTapToResumeOnboarding() {
        shouldShowOnboardingReminderDialog = false
        coordinator.navigateToOnboarding(step: onboardingStep ?? .contractorInfo)
    }
    
    func didTapCTA() {
        coordinator.navigateToOnboarding(step: .contractorInfo)
    }
    
    func didTapDialogCloseButton() {
        shouldShowOnboardingReminderDialog = false
        saveOnboardingStep.save(nil)
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
