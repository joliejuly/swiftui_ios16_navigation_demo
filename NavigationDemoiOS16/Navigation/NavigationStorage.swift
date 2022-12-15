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
    
    func add(navigationPathItem: NavigationPathItem) {
        guard !path.contains(navigationPathItem) else { return }
        navigationPathItem.isShown = true
        path.append(navigationPathItem)
    }

    func popToRoot() {
        UIApplication.enableKeyWindowAnimation()
        path.forEach { $0.isActive = false }
        path.removeLast(path.count)
    }
    
    func popTo(index: Int) {
        guard !path.isEmpty, index < path.count else { return }
        UIApplication.enableKeyWindowAnimation()
        for (idx, item) in path.enumerated() where idx >= index {
            item.isActive = false
        }
        path.removeLast(path.count - index)
    }
}
