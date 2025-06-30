import Foundation

public struct InvoiceDomain {
    let number: Int
    let issueDate: Date
    let dueDate: Date
    let amount: Double
    
    public init(number: Int, issueDate: Date, dueDate: Date, amount: Double) {
        self.number = number
        self.issueDate = issueDate
        self.dueDate = dueDate
        self.amount = amount
    }
}
