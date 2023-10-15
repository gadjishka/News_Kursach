//
//  test.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 25.09.2023.
//

import SwiftUI



struct ViewOne: View {
    @State private var isViewTwoPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("View One")
                Button("Перейти к View Two") {
                    isViewTwoPresented.toggle()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding()
                .fullScreenCover(isPresented: $isViewTwoPresented) {
                    ViewTwo()
                }
            }
        }
    }
}

struct ViewTwo: View {
    var body: some View {
        VStack {
            Text("View Two")
            Text("Нельзя вернуться назад к View One")
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .navigationBarHidden(true)
    }
}

#Preview {
    ViewOne()
}
