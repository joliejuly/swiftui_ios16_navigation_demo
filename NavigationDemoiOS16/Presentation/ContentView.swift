//
//  ContentView.swift
//  NavigationDemo
//
//  Created by Юлия Никитина on 13.09.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack(path: $storage.path) {
            ZStack {
                Image("home")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.7)
                Button {
                    storage.show(id: FirstView.id)
                } label: {
                    Text("Go!")
                        .font(.system(size: 50, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                }
            }
            .navigationLink(id: FirstView.id, title: FirstView.id) {
                AnyView(FirstView())
            }
            .navigationDestination(for: NavigationPathItem.self) { item in
                item.destination()
            }
        }
    }
    
    @ObservedObject private var storage = NavigationStorage.shared
    @State private var isFirstViewShown = false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
