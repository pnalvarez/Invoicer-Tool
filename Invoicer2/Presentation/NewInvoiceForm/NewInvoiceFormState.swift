import Foundation

struct NewInvoiceFormState {
    var invoiceId: String = ""
    var issueDate: Date = Date()
    var dueDate: Date = Date()
    var issueDateWasSelected: Bool = false
    var dueDateWasSelected: Bool = false
    var issueDateText: String = ""
    var dueDateText: String = ""
    var invoiceIdError: String?
    var issueDateError: String?
    var dueDateError: String?
    var ctaEnabled: Bool = true
}
