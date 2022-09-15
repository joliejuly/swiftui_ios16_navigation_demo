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
    @Published var path = NavigationPath()
    
    /// Хранение названий вью для навбара
    @Published var pathTitles: [String] = []
    
    func show(id: String, title: String) {
        if path.isEmpty {
            pathTitles.append("Home")
        }
        pathTitles.append(title)
        path.append(id)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
        pathTitles = []
    }
    
    func popTo(index: Int) {
        guard !path.isEmpty, index <= path.count else { return }
        path.removeLast(path.count - index)
        pathTitles = Array(pathTitles[0 ... path.count])
    }
}
