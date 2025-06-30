import SwiftUI

public struct InputField: View {
    let label: String
    let placeholder: String
    let text: Binding<String>
    let errorMessage: String?
    let disclaimerMessage: String?
    let keyboardType: UIKeyboardType
    let formatter: (String) -> String
    let didFocusChange: (Bool) -> Void
    let isDisabled: Bool
    @State private var internalText: String = ""
    @State private var isFocused: Bool = false
    @State private var hasAlreadyFocused: Bool = false
    
    public init(
        label: String,
        placeholder: String = "",
        text: Binding<String>,
        errorMessage: String? = nil,
        disclaimerMessage: String? = nil,
        keyboardType: UIKeyboardType = .default,
        formatter: @escaping (String) -> String = { $0 },
        didFocusChange: @escaping (Bool) -> Void = { _ in },
        isDisabled: Bool = false
    ) {
        self.label = label
        self.placeholder = placeholder
        self.text = text
        self.errorMessage = errorMessage
        self.disclaimerMessage = disclaimerMessage
        self.keyboardType = keyboardType
        self.formatter = formatter
        self.didFocusChange = didFocusChange
        self.isDisabled = isDisabled
        self.internalText = internalText
        self.isFocused = isFocused
        self.hasAlreadyFocused = hasAlreadyFocused
    }
    
    public var body: some View {
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
            .multilineTextAlignment(.leading)
            .keyboardType(keyboardType)
            .autocapitalization(.none)
            .disableAutocorrection(true)
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
            .disabled(isDisabled)
            
            if let errorMessage, hasAlreadyFocused {
                Spacer().frame(height: 4)
                Text(errorMessage)
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(Colors.errorPrimary)
            } else if let disclaimerMessage {
                Text(disclaimerMessage)
                    .font(.footnote)
                    .fontWeight(.light)
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
