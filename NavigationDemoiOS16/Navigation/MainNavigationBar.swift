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

    private var navigationTitlesView: some View {
        HStack {
            ForEach(storage.pathItems.sorted(by: <), id: \.key) { index, item in
                makeTitleButton(item: item, index: index, isLast: index == storage.path.count)
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func makeTitleButton(item: String, index: Int, isLast: Bool) -> some View {
        Button {
            guard !isLast else { return }
            storage.popTo(index: index)
        } label: {
            if index != 0 {
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
