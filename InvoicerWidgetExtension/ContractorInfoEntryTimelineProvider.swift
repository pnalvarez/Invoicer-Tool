import WidgetKit
import InvoicerDomainFramework
import InvoicerUseCaseFactoryFramework


struct ContractorInfoEntryTimelineProvider: TimelineProvider {
    private let placeholderEntry = ContractorInfoEntry(date: .now, data: .init())
    
    private let getContractorInfo: GetContractorInfoProtocol
    
    init(getContractorInfo: GetContractorInfoProtocol = GetContractorInfoFactory.make()) {
        self.getContractorInfo = getContractorInfo
    }
    
    func placeholder(in context: Context) -> ContractorInfoEntry {
        placeholderEntry
    }
    
    func getSnapshot(in context: Context, completion: @escaping @Sendable (ContractorInfoEntry) -> Void) {
        completion(placeholderEntry)
    }
    
    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<ContractorInfoEntry>) -> Void) {
        Task {
            
            WidgetCenter.shared.reloadAllTimelines()
            
            let contractorInfo = await getContractorInfo.get()
            
            guard let contractorInfo,
                  let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: .now) else {
                completion(Timeline(entries: [placeholderEntry], policy: .atEnd))
                return
            }
            
            let entry = ContractorInfoEntry(date: .now, data: contractorInfo)
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            completion(timeline)
        }
    }
}
