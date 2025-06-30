import SwiftUI

struct ModalDialogueView<Content: View>: ModalView {
    
    @Environment(\.presentationMode) var presentationMode // iOS 15 dimiss
    
    // MARK: - Data properties
    @ObservedObject var viewModel = ModalViewModel()
    var content: () -> Content
    var shouldDismiss: (() -> Void)?
    
    init(viewModel: ModalViewModel, content: @escaping () -> Content) {
        self.viewModel = viewModel
        self.content = content
    }
    
    init(viewModel: ModalViewModel, content: @escaping () -> Content, shouldDismiss: (() -> Void)?) {
        self.init(viewModel: viewModel, content: content)
        self.shouldDismiss = shouldDismiss
    }
    
    var body: some View {
        sheet
            .modifier(OpaqueBackgroundModifier(
                isPresented: $viewModel.isPresented,
                allowDismiss: viewModel.allowsDismiss,
                alignment: .center,
                shouldDismiss: dismissModal
            ))
    }
    
    @ViewBuilder
    var sheet: some View {
        ZStack {
            Color.white
                .cornerRadius(24)
            VStack {
                content()
            }
            .padding(.bottom, 32)
            .padding(.horizontal, 24)
            .padding(.top)
        }
        .padding(.horizontal,24)
        .fixedSize(horizontal: false, vertical: true)
    }
    
    func dismissModal() {
        if let shouldDismiss {
            shouldDismiss()
        } else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
