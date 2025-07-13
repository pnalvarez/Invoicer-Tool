import SwiftUI

struct InputField: View {
    let label: String
    var placeholder: String = ""
    var text: Binding<String>
    var errorMessage: String?
    var disclaimerMessage: String?
    var keyboardType: UIKeyboardType = .default
    var formatter: (String) -> String = { $0 }
    var didFocusChange: (Bool) -> Void = { _ in }
    var isDisabled: Bool = false
    var needsFocusToShowError: Bool = true
    @State private var internalText: String = ""
    @State private var isFocused: Bool = false
    @State private var hasAlreadyFocused: Bool = false
    
    private var showErrorState: Bool {
         errorMessage != nil && (hasAlreadyFocused || !needsFocusToShowError)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(label)
                .font(.callout)
                .fontWeight(.regular)
                .foregroundColor(showErrorState ? Colors.errorPrimary : Colors.textPrimary)
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
                    .stroke(showErrorState ? Colors.errorPrimary : isFocused ? Colors.inputHover : Colors.inputBorder.opacity(0.5), lineWidth: isFocused || errorMessage != nil && hasAlreadyFocused ? 2 : 1)
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
            
            if let errorMessage, (hasAlreadyFocused || !needsFocusToShowError) {
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
