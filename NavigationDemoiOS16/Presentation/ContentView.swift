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
                    storage.show(id: FirstView.id, title: "FirstView")
                } label: {
                    Text("Go!")
                        .font(.system(size: 50, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                }
            }
            .navigationDestination(for: String.self) { destination in
                switch destination {
                case FirstView.id:
                    FirstView()
                case SecondView.id:
                    SecondView()
                default:
                    ContentView()
                }
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
