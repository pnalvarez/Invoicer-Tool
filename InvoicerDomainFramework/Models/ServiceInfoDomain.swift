public struct ServiceInfoDomain: Codable {
    public let jobDescription: String
    public let quantity: String
    public let unitPrice: String
    
    public init(jobDescription: String, quantity: String, unitPrice: String) {
        self.jobDescription = jobDescription
        self.quantity = quantity
        self.unitPrice = unitPrice
    }
}
