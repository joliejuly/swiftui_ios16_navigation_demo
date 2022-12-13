//
//  NavigationStorage.swift
//  NavigationDemo
//
//  Created by Юлия Никитина on 14.09.2022.
//

import SwiftUI

/// Хранилище стека
final class NavigationStorage: ObservableObject {
    
    static let shared = NavigationStorage()
    
    /// Хранение стека навигации
    @Published var path = [NavigationPathItem]()
    
    func show(id: String, title: String, destination: @escaping () -> some View) {
        let item = NavigationPathItem(id: id, title: title, model: nil) { _ in
            AnyView(destination())
        }
        item.isShown = true
        path.append(item)
    }
    
    func show<Model: Any>(id: String, title: String, model: Model, destination: @escaping (Model) -> some View) {
        let item = NavigationPathItem(id: id, title: title, model: model) { model in
            if let model = model as? Model {
                return AnyView(destination(model))
            } else {
                return AnyView(EmptyView())
            }
        }
        item.isShown = true
        path.append(item)
    }
    
    func popToRoot() {
        UIApplication.enableKeyWindowAnimation()
        path.removeLast(path.count)
    }
    
    func popTo(index: Int) {
        guard !path.isEmpty, index < path.count else { return }
        UIApplication.enableKeyWindowAnimation()
        path.removeLast(path.count - index)
    }
}
