//
//  NavigationStorage.swift
//  NavigationDemo
//
//  Created by Юлия Никитина on 14.09.2022.
//

import SwiftUI

extension View {
    static var id: String {
        String(describing: self)
    }
}

/// Хранилище стека
final class NavigationStorage: ObservableObject {
    
    static let shared = NavigationStorage()
    
    /// Хранение стека навигации
    @Published var path = [NavigationPathItem]()
    
    
    func show(id: String, title: String, destination: @escaping () -> AnyView) {
        let item = NavigationPathItem(id: id, title: title, destination: destination)
        item.isShown = true
        path.append(item)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func popTo(index: Int) {
        guard !path.isEmpty, index < path.count else { return }
        path.removeLast(path.count - index)
    }
}
