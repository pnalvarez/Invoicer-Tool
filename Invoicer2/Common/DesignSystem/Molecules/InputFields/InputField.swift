import SwiftUI

struct InputField: View {
    let label: String
    var placeholder: String = ""
    var text: Binding<String>
    var errorMessage: String?
    var keyboardType: UIKeyboardType = .default
    var formatter: (String) -> String = { $0 }
    var didFocusChange: (Bool) -> Void = { _ in }
    @State private var internalText: String = ""
    @State private var isFocused: Bool = false
    @State private var hasAlreadyFocused: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(label)
                .font(.callout)
                .fontWeight(.regular)
                .foregroundColor(errorMessage != nil && hasAlreadyFocused ? Colors.errorPrimary : Colors.textPrimary)
            Spacer()
                .frame(height: 8)
            TextField(placeholder, text: text) {
                isFocused = $0
                if !$0 {
                    hasAlreadyFocused = true
                }
                didFocusChange($0)
            }
                .keyboardType(keyboardType)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(errorMessage != nil && hasAlreadyFocused ? Colors.errorPrimary : isFocused ? Colors.inputHover : Colors.inputBorder.opacity(0.5), lineWidth: isFocused || errorMessage != nil && hasAlreadyFocused ? 2 : 1)
                )
                .onChange(of: internalText) { _, newValue in
                    let formatted = formatter(newValue)
                    if formatted != newValue {
                        internalText = formatted
                    }
                    text.wrappedValue = formatted
                }
                .onAppear {
                    internalText = formatter(text.wrappedValue)
                }
            
            if let errorMessage, hasAlreadyFocused {
                Spacer().frame(height: 4)
                Text(errorMessage)
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(Colors.errorPrimary)
            }
        }
    }
}

#Preview {
    VStack {
        InputField(label: "Label", placeholder: "Insert a text here", text: .constant(""), errorMessage: "Required field") { $0.uppercased() }
            .padding()
        InputField(label: "Label", placeholder: "Insert a text here", text: .constant(""))
            .padding()
    }
}
