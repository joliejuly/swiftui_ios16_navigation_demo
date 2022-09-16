//
//  ContentView.swift
//  NavigationDemo
//
//  Created by Юлия Никитина on 13.09.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
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
            .onAppear {
                storage.addMainScreenPathItem()
            }
            .navigationLink(id: FirstView.id, title: FirstView.id, isPresented: $isFirstViewShown) {
                FirstView(isSecondViewShown: $isSecondViewShown)
            }
            .navigationLink(id: SecondView.id, title: SecondView.id, isPresented: $isSecondViewShown) {
                SecondView()
            }
        }
    }
    
    @ObservedObject private var storage = NavigationStorage.shared
    @State private var isFirstViewShown = false
    @State var isSecondViewShown = false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
