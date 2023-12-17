//
//  UserProfileView.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 18.11.2023.
//

import SwiftUI

struct UserProfileView: View {
    
    
    @State private var userName: String = "Gadji"
    @State private var userLastName: String = "Ballin"
    @State private var email: String = "gadjig@mil.ru"
    @State private var favoriteCity = "Moscow"
    @State private var isEditingCity = false
    @EnvironmentObject var mainVM: MainViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text(email)
                } header: {
                    Text("Email")
                }
                
                Section {
                    Text(favoriteCity)
                        .onTapGesture {
                            isEditingCity = true
                        }
                } header: {
                    Text("Favorite city")
                }
                
                Section {
                    Button {
                        mainVM.logout()
                    } label: {
                        Text("Log out")
                            .foregroundColor(.red)
                            
                    }
                } .frame(maxWidth: .infinity, alignment: .center)
            }
            .sheet(isPresented: $isEditingCity) {
                Text("Enter your favorite city")
                TextField("Favorite city", text: $favoriteCity, onCommit: {
                    isEditingCity = false
                })
                .padding()
            }
            
            .navigationTitle(userName + " " + userLastName)
        }
        .onAppear{
            let userData: UserData = TokenManager.getUserDataFromToken()
            
            userName = userData.firstname
            userLastName = userData.lastname
            email = userData.email
        }
    }
}

#Preview {
    UserProfileView()
}
