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
    /// Хранение названий вью для навбара
    @Published var pathItems: [NavigationPathItem] = []
    
    func addItem(_ item: NavigationPathItem) {
        guard !pathItems.contains(where: { $0.id == item.id }) else { return }
        DispatchQueue.main.async {
            self.addHomeItem()
            self.pathItems.append(item)
        }
        
    }
    
    func addHomeItem() {
        guard !pathItems.contains(where: { $0.id == NavigationPathItem.home.id }) else { return }
        pathItems.insert(NavigationPathItem.home, at: 0)
    }
    
    func show(id: String, title: String, destination: @escaping () -> AnyView) {
        let item = NavigationPathItem(id: id, title: title, destination: destination)
        NavigationStorage.shared.addItem(item)
        item.isShown = true
        path.append(item)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
        pathItems = []
    }
    
    func popTo(index: Int) {
        guard !path.isEmpty, index < path.count else { return }
        path.removeLast(path.count - index)
        pathItems = Array(pathItems[0 ... path.count])
    }
}
