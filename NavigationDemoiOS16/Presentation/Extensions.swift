//
//  Extensions.swift
//  NavigationDemoiOS16
//
//  Created by joliejuly on 16.11.2022.
//

import SwiftUI

extension View {
    static var navigationID: String {
        String(describing: self)
    }
}

extension UIApplication {
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
    static func enableKeyWindowAnimation() {
        let animation = CATransition()
        animation.isRemovedOnCompletion = true
        animation.type = .push
        animation.subtype = .fromLeft
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        UIApplication.shared.keyWindow?.layer.add(animation, forKey: nil)
    }
}
