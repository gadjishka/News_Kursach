//
//  UserProfileView.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 18.11.2023.
//

import SwiftUI

struct UserProfileView: View {
    
    
    private var userName: String = "Gadji Ballin"
    private var email: String = "gadjig@mil.ru"
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text(email)
                } header: {
                    Text("Email")
                }
                
                Section {
                    Text("Moscow")
                } header: {
                    Text("Favorite city")
                }
                
            }
            .navigationTitle(userName)
        }
    }
}

#Preview {
    UserProfileView()
}
