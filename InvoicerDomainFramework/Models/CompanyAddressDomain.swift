public struct CompanyAddressDomain: Codable {
    public let streetAddress: String
    public let city: String
    public let neighbourhood: String
    public let number: String
    public let state: String
    public let country: String
    public let zipCode: String
    
    public init(streetAddress: String, city: String, neighbourhood: String, number: String, state: String, country: String, zipCode: String) {
        self.streetAddress = streetAddress
        self.city = city
        self.neighbourhood = neighbourhood
        self.number = number
        self.state = state
        self.country = country
        self.zipCode = zipCode
    }
}
