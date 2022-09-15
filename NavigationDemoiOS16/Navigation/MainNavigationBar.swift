//
//  MainNavigationBar.swift
//  NavigationDemo
//
//  Created by Юлия Никитина on 14.09.2022.
//

import SwiftUI

/// Бар навигации с хлебными крошками
struct MainNavigationBar: View {
    
    private enum Constants {
        static let arrowImage = Image("backArrow")
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 50)
            navigationTitlesView
        }
    }

    @ObservedObject private var storage = NavigationStorage.shared

    @ViewBuilder
    private var navigationTitlesView: some View {
        HStack {
            ForEach(storage.pathTitles, id: \.self) { title in
                if let index = storage.pathTitles.firstIndex(of: title) {
                    let isLast = index == storage.pathTitles.endIndex - 1
                    makeTitleButton(item: title, index: index, isLast: isLast)
                }
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func makeTitleButton(item: String, index: Int, isLast: Bool) -> some View {
        let isHome = index == 0
        Button {
            guard !isLast else { return }
            if isHome {
                storage.popToRoot()
            } else {
                storage.popTo(index: index)
            }
        } label: {
            if !isHome {
                Constants.arrowImage
            }
            Text(item)
                .font(.system(size: 20, weight: isLast ? .heavy : .medium, design: .rounded))
                .lineLimit(1)
        }
        .frame(height: 30)
        .foregroundColor(.white)
    }
}



struct MainNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigationBar()
    }
}
