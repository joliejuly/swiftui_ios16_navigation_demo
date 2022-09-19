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
                    NavigationStorage.shared.show(id: SecondView.id)
                } label: {
                    Text("Tap me!")
                        .font(.system(size: 30, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea(.container, edges: .vertical)
        .navigationBarHidden(true)
        .navigationLink(id: SecondView.id, title: SecondView.id) {
            AnyView(SecondView())
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
