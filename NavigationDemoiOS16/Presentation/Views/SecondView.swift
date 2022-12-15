//
//  SecondView.swift
//  NavigationDemo
//
//  Created by Юлия Никитина on 14.09.2022.
//

import SwiftUI

struct SecondView: View {
    var body: some View {
        ZStack {
            Color.black
            Image("second")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack {
                MainNavigationBar()
                Spacer()
                Button {
                    isThirdViewShown = true
                } label: {
                    Text("2")
                        .font(.system(size: 60, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding()
        }
        .navigation(destination: ThirdView(), isActive: $isThirdViewShown)
        .navigationBarHidden(true)
        .ignoresSafeArea(.container, edges: .vertical)
    }
    
    @State private var isThirdViewShown = false
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
