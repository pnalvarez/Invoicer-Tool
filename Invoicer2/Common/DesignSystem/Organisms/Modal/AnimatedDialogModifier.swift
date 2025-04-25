import SwiftUI

struct AnimatedDialogModifier<Label: View>: ViewModifier {
    @StateObject private var viewModel = ModalViewModel()
    @State private var contentIsPresented: Bool = false
    @Binding var isPresented: Bool
    var label: () -> Label
    var onDismiss: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $contentIsPresented, onDismiss: {
                onDismiss?()
            }) {
                ModalDialogueView(viewModel: viewModel, content: label) {
                    isPresented = false
                }
                .background(TransparentBackground())
            }.onChange(of: isPresented) { shouldPresent in
                shouldPresent ? fadeInAnimation() : fadeOutAnimation()
            }
    }
    
    private func fadeInAnimation() {
        contentIsPresented = true
        viewModel.isPresented = true
    }
    
    private func fadeOutAnimation() {
        viewModel.isPresented = false
        contentIsPresented = false
    }
}

extension View {
    func modalDialogue<Content: View>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View {
        modifier(
            AnimatedDialogModifier(
                isPresented: isPresented,
                label: content,
                onDismiss: onDismiss
            )
        )
    }
}
