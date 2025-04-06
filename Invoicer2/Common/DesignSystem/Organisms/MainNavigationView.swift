//
//  MainNavigationView.swift
//  Invoicer2
//
//  Created by Pedro Alvarez on 06/04/25.
//

import SwiftUI

enum LeadingItem {
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
    let title: String
    let scrollable: Bool
    let leadingItem: LeadingItem?
    let leadingAction: (() -> Void)?
    let content: () -> Content
    let centerView: () -> CenterView
    let trailingView: () -> TrailingView
    
    init(
        title: String,
        scrollable: Bool = true,
        leadingItem: LeadingItem? = nil,
        leadingAction: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder centerView: @escaping () -> CenterView = { EmptyView()},
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
        VStack {
            HStack {
                if let leadingItem = leadingItem {
                    Button(action: leadingAction ?? { }) {
                        Image(systemName: leadingItem.imageName)
                            .foregroundColor(.primary)
                    }
                }
                
                Spacer()
                
                VStack {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    centerView()
                }
                
                Spacer()
                
                trailingView()
            }
        }
    }
}

struct MainNavigationViewModifier<CenterView: View, TrailingView: View>: ViewModifier {
    let title: String
    let scrollable: Bool
    let leadingItem: LeadingItem?
    let leadingAction: (() -> Void)?
    let centerView: () -> CenterView
    let trailingView: () -> TrailingView
    
    init(
        title: String,
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

extension View {
    func inMainNavigationView<CenterView: View, TrailingView: View>(
        title: String,
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
