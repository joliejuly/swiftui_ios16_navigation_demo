//
//  ContentView.swift
//  NavigationDemo
//
//  Created by Юлия Никитина on 13.09.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            if #available(iOS 16.0, *) {
                NavigationStack(path: $storage.path) {
                    content
                        .navigation(destination: FirstView(title: "Title"), isActive: $isFirstViewShown)
                        .navigationDestination(for: NavigationPathItem.self) { item in
                            item.destination(item.model)
                        }
                }
            } else {
                NavigationView {
                    content
                        .navigation(destination: FirstView(title: "Title"), isActive: $isFirstViewShown)
                }
            }
    }
    
    private var content: some View {
        ZStack {
            Color.black
            Image("home")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.7)
            Button {
                isFirstViewShown = true
            } label: {
                Text("Go!")
                    .font(.system(size: 50, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
            }
        }
        .ignoresSafeArea()
    }
    
    @StateObject private var storage = NavigationStorage.shared
    @State private var isFirstViewShown = false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
