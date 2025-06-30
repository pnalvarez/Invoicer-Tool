import SwiftData
import InvoicerDomainFramework

@Model final class ServiceInfoData {
    @Attribute var jobDescription: String
    @Attribute var quantity: String
    @Attribute var unitPrice: String
    
    init(
        jobDescription: String,
        quantity: String,
        unitPrice: String
    ) {
        self.jobDescription = jobDescription
        self.quantity = quantity
        self.unitPrice = unitPrice
    }
    
    static func fromDomainModel(_ model: ServiceInfoDomain) -> Self {
        .init(
            jobDescription: model.jobDescription,
            quantity: model.quantity,
            unitPrice: model.unitPrice
        )
    }
    
    func toDomainModel() -> ServiceInfoDomain {
        ServiceInfoDomain(
            jobDescription: jobDescription,
            quantity: quantity,
            unitPrice: unitPrice
        )
    }
}
