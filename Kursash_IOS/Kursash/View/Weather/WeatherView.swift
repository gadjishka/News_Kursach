//
//  WeatherView.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 27.09.2023.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        VStack {
            Image("clear-day")
                .resizable()
                .clipped()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .padding()
            Text("22 C°")
                .bold()
                .font(.system(size: 30))
                .padding()
            HStack(spacing: 20)
            {
                Text("Мин. 17°")
                    .font(.title3)
                Text("Макс. 23°")
                    .font(.title3)
            }
            .padding()
            
            
            
        }
    }
}

#Preview {
    WeatherView()
}
