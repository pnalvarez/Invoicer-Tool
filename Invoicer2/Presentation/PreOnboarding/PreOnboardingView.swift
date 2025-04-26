import SwiftUI

struct PreOnboardingView: View {
    @ObservedObject var viewModel: PreOnboardingViewModel
    
    var body: some View {
        VStack(spacing: .zero) {
            Text("Welcome to the Invoice tool!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Colors.textPrimary)
            Spacer()
                .frame(height: 8)
            Text("It seems like it's your first time here.")
                .font(.subheadline)
                .foregroundColor(Colors.textPrimary)
            Spacer()
                .frame(height: 24)
            PrimaryButton(text: "Start", action: viewModel.didTapCTA)
        }
        .onAppear(perform: viewModel.onAppear)
        .modalDialogue(isPresented: $viewModel.shouldShowOnboardingReminderDialog) {
            VStack(spacing: .zero) {
                Text("Resume onboarding?")
                Spacer()
                    .frame(height: 16)
                Text("You can resume the onboarding where you stopped: \(viewModel.onboardingStep?.title ?? "")")
                    .font(.body)
                    .foregroundColor(Colors.textPrimary)
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 16)
                PrimaryButton(
                    text: "Resume",
                    expandedWidth: true,
                    action: viewModel.didTapTapToResumeOnboarding)
                    Spacer()
                        .frame(height: 16)
                SecondaryButton(
                    text: "Restart",
                    expandedWidth: true,
                    action: viewModel.didTapRestartOnboarding
                )
            }
        }
    }
}

extension PreOnboardingView {
    static func getViewController(viewModel: PreOnboardingViewModel) -> UIViewController {
        UIHostingController(rootView: PreOnboardingView(viewModel: viewModel))
    }
}

#Preview {
    PreOnboardingView(viewModel: .init(coordinator: PreOnboardingCoordinator()))
}
