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
                    storage.show(id: ThirdView.navigationID, title: "Third") { 
                        ThirdView()
                    }
                } label: {
                    Text("2")
                        .font(.system(size: 60, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(.container, edges: .vertical)
    }
    
    private let storage = NavigationStorage.shared
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
