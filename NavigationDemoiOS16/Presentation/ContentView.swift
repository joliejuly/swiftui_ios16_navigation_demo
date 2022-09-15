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
                    storage.showFirst()
                } label: {
                    Text("Go!")
                        .font(.system(size: 50, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                }
            }
            .navigationDestination(for: NavigationStorage.Destination.self) { destination in
                FirstView()
            }
//            .navigationDestination(isPresented: $showDetails) {
//            ///             ColorDetail(color: favoriteColor)
//            ///         }
        }
    }
    
    @ObservedObject private var storage = NavigationStorage.shared
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
