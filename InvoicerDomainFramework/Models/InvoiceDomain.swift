import Foundation

public struct InvoiceDomain {
    public let number: Int
    public let issueDate: Date
    public let dueDate: Date
    public let amount: Double
    
    public init(number: Int, issueDate: Date, dueDate: Date, amount: Double) {
        self.number = number
        self.issueDate = issueDate
        self.dueDate = dueDate
        self.amount = amount
    }
}
