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
                Color.black
                Image("home")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.7)
                Button {
                    storage.show(id: FirstView.navigationID, title: "First", model: "Title") { title in
                        FirstView(title: title)
                    }
                } label: {
                    Text("Go!")
                        .font(.system(size: 50, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                }
            }
            .ignoresSafeArea()
            .navigationDestination(for: NavigationPathItem.self) { item in
                item.destination(item.model)
            }
        }
    }
    
    @StateObject private var storage = NavigationStorage.shared
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
