import SwiftData
import InvoicerDomainFramework

@Model public final class CompanyAddressData {
    @Attribute var streetAddress: String
    @Attribute var city: String
    @Attribute var neighbourhood: String
    @Attribute var number: String
    @Attribute var state: String
    @Attribute var country: String
    @Attribute var zipCode: String
    
    init(
        streetAddress: String,
        city: String,
        neighbourhood: String,
        number: String,
        state: String,
        country: String,
        zipCode: String
    ) {
        self.streetAddress = streetAddress
        self.city = city
        self.neighbourhood = neighbourhood
        self.number = number
        self.state = state
        self.country = country
        self.zipCode = zipCode
    }
    
    public static func fromDomainModel(_ model: CompanyAddressDomain) -> CompanyAddressData {
        return CompanyAddressData(
            streetAddress: model.streetAddress,
            city: model.city,
            neighbourhood: model.neighbourhood,
            number: model.number,
            state: model.state,
            country: model.country,
            zipCode: model.zipCode
        )
    }
    
    func toDomainModel() -> CompanyAddressDomain {
        return CompanyAddressDomain(
            streetAddress: streetAddress,
            city: city,
            neighbourhood: neighbourhood,
            number: number,
            state: state,
            country: country,
            zipCode: zipCode
        )
    }
}
