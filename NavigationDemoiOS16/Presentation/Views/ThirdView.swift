//
//  SwiftUIView.swift
//  NavigationDemoiOS16
//
//  Created by joliejuly on 16.11.2022.
//


import SwiftUI

struct ThirdView: View {
    var body: some View {
        ZStack {
            Color.black
            Image("third")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack {
                MainNavigationBar()
                Spacer()
                Text("3")
                    .font(.system(size: 60, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(.container, edges: .vertical)
    }
}


struct ThirdViewView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView()
    }
}
