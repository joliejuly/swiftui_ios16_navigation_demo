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
        let item = NavigationPathItem(id: id, title: title) {
            AnyView(destination())
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
