import SwiftUI

struct SecondaryButton: View {
    let text: String
    var enabled: Bool = true
    var expandedWidth: Bool = false
    let action: () -> Void
    
    var body: some View {
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
