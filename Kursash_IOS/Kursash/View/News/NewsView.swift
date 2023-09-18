//
//  NewsView.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 18.09.2023.
//

import SwiftUI

struct NewsView: View {
    let data = (1...20).map { "Item \($0)" }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem()], spacing: 20) {
                ForEach(data, id: \.self) { item in
                    NewsViewItem()
                }
            }
            .padding()
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
