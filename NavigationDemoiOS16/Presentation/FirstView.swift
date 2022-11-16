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
                    storage.show(id: SecondView.id, title: "Second") {
                        AnyView(SecondView())
                    }
                } label: {
                    Text("1")
                        .font(.system(size: 60, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea(.container, edges: .vertical)
        .navigationBarHidden(true)
    }
    
    private let storage = NavigationStorage.shared
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
