//
//  NewsViewItem.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 18.09.2023.
//

import SwiftUI

struct NewsViewItem: View {
    var body: some View {
        VStack {
            Text("В Россию привезли белорусский кроссовер Belgee X50")
                .font(.title3)
                .padding()
                
            Text("Это переименованный Geely Coolray.")
                .font(.subheadline)
            
            Image("image1")
                .resizable()
                .clipped()
                .frame(height: 200)
            HStack {
                Spacer()
                Text("1 час назад")
                    .font(.caption)
                    .opacity(0.5)
                Text("Денис Гурьянов")
                    .font(.caption)
                    .opacity(0.5)
            }
            
            
        } .padding()
            .background( Color(.secondarySystemGroupedBackground))
            .frame(width: .infinity)
            .cornerRadius(10)
            .shadow(radius: 7)
    }
}

struct NewsViewItem_Previews: PreviewProvider {
    static var previews: some View {
        NewsViewItem()
    }
}
