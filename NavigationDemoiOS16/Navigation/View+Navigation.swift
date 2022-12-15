// View+Navigation.swift
// Copyright © IT4IT. All rights reserved.

import SwiftUI

// swiftlint:disable custom_navigation_link

/// Модификатор навигации
@available(iOS, introduced: 14.0, deprecated: 16.0, message: "Используй новые методы навигации для iOS16 и выше")
struct NavigationModifier<Destination>: ViewModifier where Destination: View {
    let destination: Destination
    let isActive: Binding<Bool>
    let navigationPathItem: NavigationPathItem?

    init(destination: Destination, isActive: Binding<Bool>, navigationPathItem: NavigationPathItem? = nil) {
        self.destination = destination
        self.isActive = isActive
        self.navigationPathItem = navigationPathItem
        
        if #available(iOS 16.0, *), let item = navigationPathItem, isActive.wrappedValue {
            DispatchQueue.main.async {
                NavigationStorage.shared.add(navigationPathItem: item)
            }
        }
        
    }

    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
        } else {
            content
                .background(
                    NavigationLink(destination: destination, isActive: isActive) {
                        EmptyView()
                    }
                        .hidden()
                )
        }
        
    }
}

/// Модификатор навигации с моделью
@available(iOS, introduced: 14.0, deprecated: 16.0, message: "Используй новые методы навигации для iOS16 и выше")
struct NavigationModelModifier<Destination: View, Model: Any>: ViewModifier {
    let model: Model?
    let isActive: Binding<Bool>
    let destinationHandler: ((Model) -> (Destination))?

    private var destinationView: some View {
        Group {
            if let model = model, let view = destinationHandler?(model) {
                view
            } else {
                EmptyView()
            }
        }
    }

    init(model: Model?, isActive: Binding<Bool>, destinationHandler: @escaping (Model) -> (Destination)) {
        self.model = model
        self.isActive = isActive
        self.destinationHandler = destinationHandler
    }

    func body(content: Content) -> some View {
        content
            .background(
                NavigationLink(destination: destinationView, isActive: isActive) {
                    EmptyView()
                }
                .hidden()
            )
    }
}

// swiftlint:enable custom_navigation_link

/// Расширение для навигации
@available(iOS, introduced: 14.0, deprecated: 16.0, message: "Используй новые методы навигации для iOS16 и выше")
public extension View {
    func navigation<Destination: View>(
        destination: Destination,
        isActive: Binding<Bool>,
        id: String = Destination.navigationID
    ) -> some View {
        if #available(iOS 16, *) {
            let navigationPathItem = NavigationPathItem(id: id, title: id, isActive: isActive) { _ in
                AnyView(destination)
            }
            return modifier(NavigationModifier(destination: destination, isActive: isActive, navigationPathItem: navigationPathItem))
        } else {
            return modifier(NavigationModifier(destination: destination, isActive: isActive))
        }
    }

    func navigation<Destination: View, Model: Any>(
        model: Model?,
        isActive: Binding<Bool>,
        destinationHandler: @escaping (Model) -> (Destination)
    ) -> some View {
        if #available(iOS 16, *) {
            return self
        } else {
            return modifier(NavigationModelModifier(model: model, isActive: isActive, destinationHandler: destinationHandler))
        }
    }
}
