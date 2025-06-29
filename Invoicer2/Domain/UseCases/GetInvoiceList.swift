protocol GetInvoiceListProtocol {
    func get() -> [InvoiceDomain]
}

final class GetInvoiceList: GetInvoiceListProtocol {
    func get() -> [InvoiceDomain] {
        [.init(number: 1, issueDate: .now, dueDate: .now, amount: 10.320), .init(number: 2, issueDate: .now, dueDate: .now, amount: 10.320), .init(number: 3, issueDate: .now, dueDate: .now, amount: 10.320), .init(number: 4, issueDate: .now, dueDate: .now, amount: 10.320), .init(number: 5, issueDate: .now, dueDate: .now, amount: 10.320)]
    }
}
