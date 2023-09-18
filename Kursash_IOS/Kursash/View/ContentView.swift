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
            Text("Библиотка")
                .tabItem {
                    Image(systemName: "book")
                    Text("Библиотка")
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
