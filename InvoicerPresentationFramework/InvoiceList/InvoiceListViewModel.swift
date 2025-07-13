import Combine
import InvoicerDomainFramework

final class InvoiceListViewModel: ObservableObject {
    private let getInvoiceList: GetInvoiceListProtocol
    private let coordinator: InvoiceListCoordinatorProtocol
    @Published var invoiceList: [InvoiceUI] = []
    @Published var isAmountVisible: Bool = false
    
    init(getInvoiceList: GetInvoiceListProtocol = GetInvoiceList(), coordinator: InvoiceListCoordinatorProtocol) {
        self.getInvoiceList = getInvoiceList
        self.coordinator = coordinator
    }
    
    func onAppear() {
        let invoiceList = getInvoiceList.get()
        self.invoiceList = invoiceList.map { InvoiceUI(from: $0)}
    }
    
    func didTapAddInvoice() {
        coordinator.navigateToNewInvoiceForms()
    }
    
    func didTapVisibilityIcon() {
        isAmountVisible.toggle()
    }
}
