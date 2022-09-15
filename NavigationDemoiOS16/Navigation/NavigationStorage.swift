//
//  NavigationStorage.swift
//  NavigationDemo
//
//  Created by Юлия Никитина on 14.09.2022.
//

import SwiftUI

/// Хранилище стека навигации
final class NavigationStorage: ObservableObject {
    
    enum Destination {
        case first
        case second
    }
    
    static let shared = NavigationStorage()
    
    /// Хранилище стека навигации в iOS16
    @Published var path = NavigationPath()
    
    
    func showFirst() {
        path.append(Destination.first)
    }
    
    func showSecond() {
        path.append(Destination.second)
    }
    
    func popTo(id: Destination) {
        // TODO: index
        path.removeLast()
    }
}
