import SwiftUI

public struct SecondaryButton: View {
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
                .foregroundColor(enabled ? Colors.buttonPrimary : Colors.primaryDisabled)
                .padding(8)
            
            extraSpacer
        })
        .disabled(!enabled)
        .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(enabled ? Colors.buttonPrimary : Colors.primaryDisabled, lineWidth: 1)
                    )
    }
    
    @ViewBuilder
    var extraSpacer: some View {
        if expandedWidth {
            Spacer()
        }
    }
}

#Preview {
    SecondaryButton(text: "Test", expandedWidth: true, action: { })
        .padding()
    SecondaryButton(text: "Test", enabled: false, expandedWidth: true, action: { })
        .padding()
}
