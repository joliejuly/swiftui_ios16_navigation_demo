//
//  FirstView.swift
//  NavigationDemo
//
//  Created by Юлия Никитина on 14.09.2022.
//

import SwiftUI

struct FirstView: View {
    
    var body: some View {
        ZStack {
            Color.black
            Image("first")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack {
                MainNavigationBar()
                Spacer()
                Button {
                    NavigationStorage.shared.showSecond()
                } label: {
                    Text("Tap me!")
                        .font(.system(size: 30, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                }
                .navigationDestination(for: NavigationStorage.Destination.self) { destination in
                    SecondView()
                }
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea(.container, edges: .vertical)
        .navigationBarHidden(true)
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
