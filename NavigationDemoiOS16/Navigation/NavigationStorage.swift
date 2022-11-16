//
//  NavigationStorage.swift
//  NavigationDemo
//
//  Created by Юлия Никитина on 14.09.2022.
//

import SwiftUI
import UIKit

extension View {
    static var navigationID: String {
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
        enableAnimations()
        path.removeLast(path.count)
    }
    
    func popTo(index: Int) {
        guard !path.isEmpty, index < path.count else { return }
        enableAnimations()
        path.removeLast(path.count - index)
    }
    
    private func enableAnimations() {
        let animation = CATransition()
        animation.isRemovedOnCompletion = true
        animation.type = .push
        animation.subtype = .fromLeft
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        UIApplication.shared.keyWindow?.layer.add(animation, forKey: nil)
    }
}
