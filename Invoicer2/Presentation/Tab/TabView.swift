import SwiftUI

struct TabItem: Hashable, Identifiable {
    let label: String
    let icon: String
    
    var id: Int {
        hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(label)
        hasher.combine(icon)
    }
    
    static func == (lhs: TabItem, rhs: TabItem) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    static var invoice: Self {
        .init(
            label: "Invoice",
            icon: "doc.text"
        )
    }
    
    static var settings: Self {
        .init(
            label: "Settings",
            icon: "gearshape"
        )
    }
}

enum TabRoute: Hashable {
    case newInvoice
    case backup
}

struct TabView: View {
    @ObservedObject var viewModel: TabViewModel
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                switch viewModel.selectedTab {
                case .invoice:
                    InvoiceListBuilder().build(path: $path)
                case .settings:
                    SettingsView()
                default:
                    EmptyView()
                }
            }
            .navigationDestination(for: TabRoute.self) { route in
                switch route {
                case .newInvoice:
                    NewInvoiceFormBuilder().build(path: $path)
                case .backup:
                    BackupView()
                }
            }
            Spacer()
            TabBottomBar(
                items: [.invoice, .settings], selectedItem: .invoice,
                onSelect: viewModel.didSelectTab
            )
            .ignoresSafeArea(edges: [.bottom])
        }
    }
}

private struct TabBottomBar: View {
    let items: [TabItem]
    @State private var selectedItem: TabItem
    let onSelect: (TabItem) -> Void
    
    init(
        items: [TabItem],
        selectedItem: TabItem,
        onSelect: @escaping (TabItem) -> Void,
    ) {
        self.items = items
        _selectedItem = State(initialValue: selectedItem)
        self.onSelect = onSelect
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color.black.opacity(0.1))
                .frame(height: 1)
                .blur(radius: 2)
            HStack(spacing: 20) {
                ForEach(items) { item in
                    Spacer()
                    VStack(spacing: 4) {
                        Image(systemName: item.icon)
                            .renderingMode(.template)
                               .resizable()
                               .scaledToFit()
                               .frame(width: 24, height: 24)
                               .foregroundColor(selectedItem.hashValue == item.hashValue ? Colors.buttonPrimary : .gray)
                        Text(item.label)
                            .foregroundColor(selectedItem.hashValue == item.hashValue  ? Colors.buttonPrimary : Color.gray)
                    }.onTapGesture {
                        selectedItem = item
                        onSelect(item)
                    }
                    Spacer()
                }
            }
            .padding(.vertical)
        }
        .frame(height: 50)
    }
}

#Preview {
    TabView(viewModel: .init(coordinator: TabCoordinator()))
}
