//
//  InitialUserView.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 16.09.2023.
//

import SwiftUI

struct InitialUserView: View {
    
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var isContentViewPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Добро пожаловать")
                    .font(.largeTitle)
                    .padding()
                
                TextField("Логин", text: $login)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 40)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 40)
                
                TextField("Пароль", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 40)
                    .padding(.horizontal, 40)
                
                Button {
                    isContentViewPresented.toggle()
                } label: {
                    Text("Войти")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                .frame(width: 150, height: 70)
                .background(Color(red: 0.4627, green: 0.8392, blue: 1.0))
                .cornerRadius(10)
                .fullScreenCover(isPresented: $isContentViewPresented) {
                    ContentView()
                }
                Spacer()
                HStack {
                    Text("Нет аккаунта?")
                    NavigationLink("Регистрация", destination: RegistrationUserView())
                    
                }
            }
            .navigationTitle("Вход")
            .toolbar(.hidden, for: .navigationBar)
        }
        
    }
}

struct InitialUserView_Previews: PreviewProvider {
    static var previews: some View {
        InitialUserView()
    }
}
