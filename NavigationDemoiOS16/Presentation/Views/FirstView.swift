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
                    isSecondViewShown = true
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
        .navigation(destination: SecondView(), isActive: $isSecondViewShown)
        .ignoresSafeArea(.container, edges: .vertical)
        .navigationBarHidden(true)
    }
    
    @State private var stepperValue: Float = 0
    @State private var isSecondViewShown = false
    
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
