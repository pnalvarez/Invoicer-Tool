
import SwiftUI

struct InvoiceListView: View {
    @ObservedObject var viewModel: InvoiceListViewModel
    
    var body: some View {
        mainContent
            .inMainNavigationView(
                title: "Invoice List",
                trailingView: {
                    HStack {
                        Button(action: viewModel.didTapVisibilityIcon) {
                            Image(systemName: viewModel.isAmountVisible ? "eye" : "eye.slash")
                                .tint(Colors.textPrimary)
                        }
                        Button(action: viewModel.didTapAddInvoice) {
                            Image(systemName: "plus")
                                .tint(Colors.textPrimary)
                        }
                    }
                })
            .onAppear(perform: viewModel.onAppear)
    }
    
    private var mainContent: some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            ForEach(viewModel.invoiceList, id: \.title) { invoice in
                InvoiceItemView(data: invoice, isAmountHidden: !viewModel.isAmountVisible)
            }
        }
        .padding(.horizontal)
    }
}
