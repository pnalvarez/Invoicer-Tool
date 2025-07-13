import InvoicerDomainFramework

struct InvoiceUI {
    let title: String
    let issueDate: String
    let dueDate: String
    let amount: String
    
    init(title: String, issueDate: String, dueDate: String, amount: String) {
        self.title = title
        self.issueDate = issueDate
        self.dueDate = dueDate
        self.amount = amount
    }
    
    init(from domainModel: InvoiceDomain) {
        self.title = "Invoice \(domainModel.number)"
        self.issueDate = domainModel.issueDate.formatted()
        self.dueDate = domainModel.dueDate.formatted()
        self.amount = domainModel.amount.formatted()
    }
}
