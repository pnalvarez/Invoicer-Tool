import Combine

final class TabViewModel: ObservableObject {
    @Published var selectedTab: TabItem = .invoice
    private let coordinator: TabCoordinatorProtocol
    
    init(selectedTab: TabItem = .invoice, coordinator: TabCoordinatorProtocol) {
        self.selectedTab = selectedTab
        self.coordinator = coordinator
    }
    
    func didSelectTab(_ item: TabItem) {
        selectedTab = item
    }
}
