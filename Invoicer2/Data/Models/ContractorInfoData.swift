import SwiftData

@Model final class ContractorInfoData {
    @Attribute var fullName: String
    @Attribute var taxId: String
    @Attribute var companyName: String
    @Attribute var companyEmail: String
    
    init(
        fullName: String,
        taxId: String,
        companyName: String,
        companyEmail: String
    ) {
        self.fullName = fullName
        self.taxId = taxId
        self.companyName = companyName
        self.companyEmail = companyEmail
    }
    
    static func fromDomainModel(_ model: ContractorInfoDomain) -> Self {
        Self(
            fullName: model.fullName,
            taxId: model.companyName,
            companyName: model.companyName,
            companyEmail: model.companyEmail
        )
    }
    
    func toDomainModel() -> ContractorInfoDomain {
        .init(
            fullName: fullName,
            cnpj: taxId,
            companyName: companyName,
            companyEmail: companyEmail
        )
    }
}
