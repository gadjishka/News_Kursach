//
//  ContentView.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 16.09.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Погода")
                .tabItem {
                    Image(systemName: "cloud")
                    Text("Погода")
                }
            NewsView()
                .tabItem {
                    Image(systemName: "text.bubble")
                    Text("Новости")
                }
            Text("Аккаунт")
                .tabItem {
                    Image(systemName: "person")
                    Text("Аккаунт")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
