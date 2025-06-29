import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            mainContent
                .inMainNavigationView(
                    leadingItem: .backArrow,
                    leadingAction: viewModel.didTapBack,
                    centerView: {
                        StepProgressIndicator(step: viewModel.step.count, total: 4, size: .small)
                            .frame(maxWidth: 120)
                    },
                    trailingView: { Button(action: viewModel.didTapInfo) {
                        Image(systemName: "info.circle")
                            .tint(Colors.textPrimary)
                    }
                    }
                )
            
            Spacer()
            
            PrimaryButton(
                text: "Save",
                enabled: viewModel.ctaEnabled,
                expandedWidth: true,
                action: viewModel.didTapCTA
            )
            .padding(.bottom, 32)
            .padding(.horizontal, 20)
            
        }
        .modalDialogue(isPresented: $viewModel.shouldShowInfoDialog) {
            VStack(spacing: .zero) {
                Text(viewModel.step.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Colors.textPrimary)
                Spacer()
                    .frame(height: 16)
                Text(viewModel.step.description)
                    .font(.body)
                    .foregroundColor(Colors.textPrimary)
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 16)
                PrimaryButton(
                    text: "Close",
                    expandedWidth: true,
                    action: viewModel.didTapCloseInfoDialog
                )
            }
        }
        .environmentObject(viewModel)
    }
    
    private var mainContent: some View {
        VStack(spacing: .zero) {
            Text(viewModel.step.title)
                .font(.headline)
                .foregroundColor(Colors.textPrimary)
            
            Spacer().frame(height: 16)
            
            Text(viewModel.step.description)
                .font(.body)
                .foregroundColor(Colors.textPrimary)
                .multilineTextAlignment(.center)
            
            Spacer().frame(height: 40)
            
            switch viewModel.step {
            case .contractorInfo:
                OnboardingContractorInfoView()
            case .companyAddress:
                OnboardingCompanyAddressView()
            case .bankInfo:
                OnboardingBankInfoView()
            case .serviceInfo:
                OnboardingServiceInfoView()
            default:
                EmptyView()
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 20)
    }
}

extension OnboardingView {
    func getViewController(viewModel: OnboardingViewModel) -> UIViewController {
        UIHostingController(rootView: OnboardingView(viewModel: viewModel))
    }
}

#Preview {
    OnboardingView(viewModel: OnboardingViewModel(coordinator: OnboardingCoordinator()))
}
