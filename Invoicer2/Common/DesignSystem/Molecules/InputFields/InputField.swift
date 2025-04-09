import SwiftUI

struct InputField: View {
    let label: String
    var placeholder: String = ""
    var text: Binding<String>
    var errorMessage: String?
    @State private var isFocused: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(label)
                .font(.callout)
                .fontWeight(.regular)
                .foregroundColor(errorMessage != nil ? Colors.errorPrimary : Colors.textPrimary)
            Spacer()
                .frame(height: 8)
            TextField(placeholder, text: text) { isFocused = $0 }
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(errorMessage != nil ? Colors.errorPrimary : isFocused ? Colors.inputHover : Colors.inputBorder.opacity(0.5), lineWidth: isFocused || errorMessage != nil ? 2 : 1)
                )
            
            if let errorMessage {
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
        InputField(label: "Label", placeholder: "Insert a text here", text: .constant(""), errorMessage: "Required field")
            .padding()
        InputField(label: "Label", placeholder: "Insert a text here", text: .constant(""))
            .padding()
    }
}
