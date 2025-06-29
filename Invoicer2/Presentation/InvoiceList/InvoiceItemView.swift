import SwiftUI

struct InvoiceItemView: View {
    let data: InvoiceUI
    let isAmountHidden: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(data.title)
                    .fontWeight(.bold)
                Text("Issued: \(data.issueDate)")
                    .font(.caption)
                Text("Due: \(data.issueDate)")
                    .font(.caption)
                Text("US$ \(isAmountHidden ? "**,**" : data.amount)")
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.black)
        }
        .padding()
        .background(
            RoundedRectangle(
                cornerRadius: 8)
            .fill(Colors.surface)
            .shadow(
                color: Color.gray.opacity(0.3),
                radius: 4, x: 0, y: 2))
    }
}

#Preview {
    InvoiceItemView(data: .init(from: .init(number: 1, issueDate: .now, dueDate: .now, amount: 6320.08)), isAmountHidden: false)
}
