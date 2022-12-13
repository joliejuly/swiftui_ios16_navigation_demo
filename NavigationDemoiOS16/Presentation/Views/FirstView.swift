//
//  FirstView.swift
//  NavigationDemo
//
//  Created by Юлия Никитина on 14.09.2022.
//

import SwiftUI

struct FirstView: View {
    
    let title: String
    
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
                    storage.show(id: SecondView.navigationID, title: "Second") {
                        SecondView()
                    }
                } label: {
                    Text("1")
                        .font(.system(size: 60, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                }
                stepper
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea(.container, edges: .vertical)
        .navigationBarHidden(true)
    }
    
    private let storage = NavigationStorage.shared
    
    @State private var stepperValue: Float = 0
    
    private var stepper: some View {
        Stepper(value: $stepperValue, in: 1...30) {
            Text(String(stepperValue))
                .font(.title)
        }
        .padding()
        .background(
            Color.white
                .mask {
                    RoundedRectangle(cornerRadius: 8)
                }
        )
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView(title: "")
    }
}
