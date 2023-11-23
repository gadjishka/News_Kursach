//
//  LoadingView.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 20.10.2023.
//

import SwiftUI

struct LoadingView: View {
    let color = #colorLiteral(red: 0.5811814666, green: 0.8301858306, blue: 0.9220091105, alpha: 1)
    var body: some View {
        ZStack {
            ZStack {
                Color(color)
            }
            .ignoresSafeArea()
            VStack(spacing: 0) {
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(10)
                    .frame(width: 200, height: 200)
                    .padding(.top, 74)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .scaleEffect(1.2)
                    .padding(.top, 26)
                Text("Пытаемся узнать кто ты такой")
                    .foregroundColor(.black)
                    .padding(12)
            }
        }
        
    }
}

#Preview {
    LoadingView()
}
