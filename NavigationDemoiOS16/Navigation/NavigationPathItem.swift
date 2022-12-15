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
    /// Открыт ли экран
    @Binding var isActive: Bool
    /// Создание экрана для перехода
    var destination: () -> AnyView

    init(id: String, title: String, isActive: Binding<Bool>, isShown: Bool = false, destination: @escaping () -> AnyView) {
        self.id = id
        self.title = title
        self._isActive = isActive
        self.destination = destination
    }
    
    static func == (lhs: NavigationPathItem, rhs: NavigationPathItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
