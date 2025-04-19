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
