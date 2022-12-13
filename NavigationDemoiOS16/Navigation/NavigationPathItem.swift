//
//  NavigationPathItem.swift
//  NavigationDemo
//
//  Created by Юлия Никитина on 14.09.2022.
//

import SwiftUI

/// Информация об экранах навигации
final class NavigationPathItem: Identifiable, Hashable {

    /// Идентификатор
    let id: String
    /// Название экрана
    let title: String?
    
    var isShown: Bool
    
    var model: Any?
    
    var destination: (Any?) -> AnyView

    init(id: String, title: String, isShown: Bool = false, model: Any? = nil, destination: @escaping (Any?) -> AnyView) {
        self.id = id
        self.title = title
        self.isShown = isShown
        self.model = model
        self.destination = destination
    }
    
    static func == (lhs: NavigationPathItem, rhs: NavigationPathItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
