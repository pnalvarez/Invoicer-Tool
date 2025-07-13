import SwiftUI
import InvoicerCommonFramework

struct OnboardingSuccessView: View {
    @ObservedObject var viewModel: OnboardingSuccessViewModel
    
    var body: some View {
        VStack(spacing: .zero) {
            Text("Account ready!")
                .font(.title)
                .fontWeight(.bold)
            Spacer().frame(height: 16)
            Text("We've set up your data. Now you are ready to start invoicing!")
                .font(.callout)
            Spacer().frame(height: 48)
            PrimaryButton(
                text: "Go to Home",
                expandedWidth: true,
                action: viewModel.didTapCTA
            )
        }
        .padding(.horizontal, 20)
    }
}

extension OnboardingSuccessView {
    static func getViewController(viewModel: OnboardingSuccessViewModel) -> UIViewController {
        UIHostingController(rootView: OnboardingSuccessView(viewModel: viewModel))
    }
}

#Preview {
    OnboardingSuccessView(viewModel: OnboardingSuccessViewModel(benefitiaryName: "Pedro Alvarez", coordinator: OnboardingSuccessCoordinator()))
}
