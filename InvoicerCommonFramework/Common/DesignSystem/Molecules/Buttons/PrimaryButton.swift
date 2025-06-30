import SwiftUI

public struct PrimaryButton: View {
    let text: String
    var enabled: Bool
    var expandedWidth: Bool
    let action: () -> Void
    
    public init(
        text: String,
        enabled: Bool = true,
        expandedWidth: Bool = false,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.enabled = enabled
        self.expandedWidth = expandedWidth
        self.action = action
    }
    
    public var body: some View {
        Button(action: action, label: {
            extraSpacer
            
            Text(text)
                .font(.body)
                .foregroundColor(Color.white)
                .padding(8)
            
            extraSpacer
        })
        .disabled(!enabled)
        .background(enabled ? Colors.buttonPrimary : Colors.primaryDisabled)
        .cornerRadius(16)
    }
    
    @ViewBuilder
    var extraSpacer: some View {
        if expandedWidth {
            Spacer()
        }
    }
}

#Preview {
    PrimaryButton(text: "Test", expandedWidth: true, action: { })
        .padding()
    PrimaryButton(text: "Test", enabled: false, expandedWidth: true, action: { })
        .padding()
}
