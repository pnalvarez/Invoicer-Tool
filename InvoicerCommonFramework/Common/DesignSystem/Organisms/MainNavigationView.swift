import SwiftUI

public enum LeadingItem {
    case close
    case backArrow
    
    var imageName: String {
        switch self {
        case .close:
            return "xmark"
        case .backArrow:
            return "chevron.left"
        }
    }
}

private struct MainNavigationView<Content: View, CenterView: View, TrailingView: View>: View {
    var title: String?
    let scrollable: Bool
    let leadingItem: LeadingItem?
    let leadingAction: (() -> Void)?
    let content: () -> Content
    let centerView: () -> CenterView
    let trailingView: () -> TrailingView

    init(
        title: String? = nil,
        scrollable: Bool = true,
        leadingItem: LeadingItem? = nil,
        leadingAction: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder centerView: @escaping () -> CenterView = { EmptyView() },
        @ViewBuilder trailingView: @escaping () -> TrailingView = { EmptyView() }
    ) {
        self.title = title
        self.scrollable = scrollable
        self.leadingItem = leadingItem
        self.leadingAction = leadingAction
        self.content = content
        self.centerView = centerView
        self.trailingView = trailingView
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    if let leadingItem {
                        Button(action: leadingAction ?? { }) {
                            Image(systemName: leadingItem.imageName)
                                .foregroundColor(Colors.buttonPrimary)
                        }
                    }
                    
                    Spacer()
                    
                    trailingView()
                }
                .padding(.horizontal, 16)
                
                if let title {
                    Text(title)
                        .font(.title3)
                        .fontWeight(.bold)
                } else {
                    centerView()
                }
            }
            .padding(.vertical, 16)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.1)),
                alignment: .bottom
            )
            .frame(maxHeight: 68)

            // Content area
            if scrollable {
                ScrollView(showsIndicators: false) {
                    content()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            } else {
                Spacer()
                content()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .bottom)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}


struct MainNavigationViewModifier<CenterView: View, TrailingView: View>: ViewModifier {
    var title: String?
    let scrollable: Bool
    let leadingItem: LeadingItem?
    let leadingAction: (() -> Void)?
    let centerView: () -> CenterView
    let trailingView: () -> TrailingView
    
    init(
        title: String? = nil,
        scrollable: Bool = true,
        leadingItem: LeadingItem? = nil,
        leadingAction: (() -> Void)? = nil,
        @ViewBuilder centerView: @escaping () -> CenterView = { EmptyView()},
        @ViewBuilder trailingView: @escaping () -> TrailingView = { EmptyView() }
    ) {
        self.title = title
        self.scrollable = scrollable
        self.leadingItem = leadingItem
        self.leadingAction = leadingAction
        self.centerView = centerView
        self.trailingView = trailingView
    }
    
    func body(content: Content) -> some View {
        MainNavigationView(
            title: title,
            scrollable: scrollable,
            leadingItem: leadingItem,
            leadingAction: leadingAction,
            content: { content },
            centerView: centerView,
            trailingView: trailingView
        )
    }
}

public extension View {
    func inMainNavigationView<CenterView: View, TrailingView: View>(
        title: String? = nil,
        scrollable: Bool = true,
        leadingItem: LeadingItem? = nil,
        leadingAction: (() -> Void)? = nil,
        @ViewBuilder centerView: @escaping () -> CenterView = { EmptyView() },
        @ViewBuilder trailingView: @escaping () -> TrailingView = { EmptyView() }
    ) -> some View {
        modifier(MainNavigationViewModifier(
            title: title,
            scrollable: scrollable,
            leadingItem: leadingItem,
            leadingAction: leadingAction,
            centerView: centerView,
            trailingView: trailingView
        ))
    }
}
