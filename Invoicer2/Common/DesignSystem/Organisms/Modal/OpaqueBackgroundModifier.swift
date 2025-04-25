import SwiftUI

struct OpaqueBackgroundModifier: ViewModifier {
    
    let fullOpacity: Double = 0.5
    let hiddenOpacity: Double = 0.0
    
    // MARK: - Data properties
    @Binding var isPresented: Bool
    let allowDismiss: Bool
    let alignment: Alignment
    
    var shouldDismiss: () -> Void

    func body(content: Content) -> some View {
        ZStack(alignment: alignment) {
            opaqueBackground
            content
        }
    }
    
    @ViewBuilder
    private var opaqueBackground: some View {
        Color.black
            .opacity(isPresented ? fullOpacity : hiddenOpacity)
            .ignoresSafeArea()
            .onTapGesture { fadeOutAndDismiss() }
    }
    
    private func fadeOutAndDismiss() {
        guard allowDismiss else { return }
        shouldDismiss()
    }
}
