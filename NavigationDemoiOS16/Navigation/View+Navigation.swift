// View+Navigation.swift
// Copyright © IT4IT. All rights reserved.

import SwiftUI

// swiftlint:disable custom_navigation_link

/// Модификатор навигации
struct NavigationModifier<Destination>: ViewModifier where Destination: View {
    let destination: Destination
    let isActive: Binding<Bool>

    init(destination: Destination, isActive: Binding<Bool>) {
        self.destination = destination
        self.isActive = isActive
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
public extension View {
    func navigation<Destination: View>(
        destination: Destination,
        isActive: Binding<Bool>,
        id: String = Destination.navigationID,
        title: String = Destination.navigationID
    ) -> some View {
        if #available(iOS 16, *) {
            addNavigationItem(id: id, title: title, destination: destination, isActive: isActive)
            return self
        } else {
            return modifier(NavigationModifier(destination: destination, isActive: isActive))
        }
    }

    func navigation<Destination: View, Model: Any>(
        model: Model?,
        isActive: Binding<Bool>,
        id: String = Destination.navigationID,
        title: String = Destination.navigationID,
        destinationHandler: @escaping (Model) -> (Destination)
    ) -> some View {
        if #available(iOS 16, *) {
            addNavigationItem(id: id, title: title, isActive: isActive, model: model, destinationHandler: destinationHandler)
            return self
        } else {
            return modifier(NavigationModelModifier(model: model, isActive: isActive, destinationHandler: destinationHandler))
        }
    }
    
    private func addNavigationItem<Destination: View>(
        id: String,
        title: String,
        destination: Destination,
        isActive: Binding<Bool>
    ) {
        let navigationPathItem = NavigationPathItem(id: id, title: title, isActive: isActive) {
            AnyView(destination)
        }
        addToPath(navigationPathItem, isActive: isActive.wrappedValue)
    }
    
    private func addNavigationItem<Destination: View, Model: Any>(
        id: String,
        title: String,
        isActive: Binding<Bool>,
        model: Model?,
        destinationHandler: @escaping (Model) -> (Destination)
    ) {
        guard let model else { return }
        let navigationPathItem = NavigationPathItem(id: id, title: title, isActive: isActive) {
            AnyView(destinationHandler(model))
        }
        addToPath(navigationPathItem, isActive: isActive.wrappedValue)
        
    }
    
    private func addToPath(_ navigationPathItem: NavigationPathItem, isActive: Bool) {
        guard isActive else { return }
        DispatchQueue.main.async {
            NavigationStorage.shared.add(navigationPathItem: navigationPathItem)
        }
    }
}
