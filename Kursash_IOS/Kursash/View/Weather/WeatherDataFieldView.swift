//
//  WeatherDataFieldView.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 15.10.2023.
//

import SwiftUI

struct WeatherDataFieldView: View {
    let title: String
    let value: String
    let image: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            if image != "" {
                Image(systemName: image)
                    .font(.system(size: 30))
            }
            Text(title)
                .font(.system(size: 17))
            Text(value)
                .font(.title3)
        } .frame(width: 150, height: 80)
            .padding(10)
        
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
            }
            .padding()
        
        
    }
}

#Preview {
    WeatherDataFieldView(title: "Moscow", value: "sdfs", image: "sunset")
}
