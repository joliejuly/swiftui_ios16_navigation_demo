//
//  NavigationStorage.swift
//  NavigationDemo
//
//  Created by Юлия Никитина on 14.09.2022.
//

import SwiftUI

/// Хранилище стека навигации
final class NavigationStorage: ObservableObject {
    
    enum Destination: Int {
        case first = 1
        case second
    }
    
    static let shared = NavigationStorage()
    
    /// Хранилище стека навигации в iOS16
    @Published var path = NavigationPath()
    @Published var pathItems: [Int: String] = [:]
    
    func show(index: Int, title: String) {
        pathItems[0] = "Home"
        pathItems[index] = title
        if let destination = Destination(rawValue: index) {
            path.append(destination)
        }
    }
    
    func popTo(index: Int) {
        guard !path.isEmpty, index <= path.count else { return }
        // удаляем вью из стека
        // примечание: для popToRoot анимация перехода не работает
        path.removeLast(path.count - index)
        // удаляем названия вью из таббара
        for (key, _) in pathItems {
            if key > path.count {
                pathItems[key] = nil
            }
        }
    }
}
