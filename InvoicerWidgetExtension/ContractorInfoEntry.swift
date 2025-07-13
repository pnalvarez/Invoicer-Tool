import WidgetKit
import InvoicerDomainFramework

struct ContractorInfoEntry: TimelineEntry {
    let date: Date // The entry timestamp
    let data: ContractorInfoDomain // The data to populate UI
}

