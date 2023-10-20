//
//  LoginView.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 17.10.2023.
//

import SwiftUI

struct LoginView: View {
    @State
    var login = ""
    @State
    var password = ""
    @State private var token = ""
    let color = #colorLiteral(red: 0.5811814666, green: 0.8301858306, blue: 0.9220091105, alpha: 1)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(color)
            }
            .ignoresSafeArea()
            ScrollView {
                
                VStack(spacing: 0) {
                    Image("logo")
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(10)
                        .frame(width: 200, height: 200)
                        .padding(.top, 74)
                    VStack(spacing: 0) {
                        Text("Sign in")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        HStack {
                            Text("Login")
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.top, 12)
                        
                        TextField("", text: $login.animation())

                        
                        HStack {
                            Text("Password")
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.top, 12)
                        
                        SecureField("", text: $password)

                        Button {
                            authenticateUser(email: login, password: password) { (authResponse, error) in
                                if let authResponse = authResponse {
                                    token = authResponse.token
                                    print("Успешная авторизация. Токен: \(authResponse.token)")
                                    // Здесь можно сохранить токен для будущих запросов
                                } else if let error = error {
                                    print("Ошибка при авторизации: \(error)")
                                }
                            }
                        } label: {
                            Text("Authorize")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background(Color(color))
                        }
                        
                        .cornerRadius(10)
                        .padding(.top, 26)
                        .padding(.horizontal, 24)
                        
                        Button {
                            getDataWithToken(token: token) { (data, error) in
                                if let data = data {
                                    if let responseString = String(data: data, encoding: .utf8) {
                                        print("Данные с сервера: \(responseString)")
                                        // Здесь обрабатывайте данные с сервера
                                    } else {
                                        print("Не удалось преобразовать данные в строку.")
                                    }
                                } else if let error = error {
                                    print("Ошибка при получении данных: \(error)")
                                }
                            }
                        } label: {
                            Text("Get info")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background(Color(color))
                        }
                        
                        .cornerRadius(10)
                        .padding(.top, 26)
                        .padding(.horizontal, 24)
                        
                        
                    }
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .padding(.horizontal, 40)
                    .padding(.top, 30)
                    
                    
                    
                    
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .navigationBarTitle("Authorization", displayMode: .inline)
        .background(Color.white.ignoresSafeArea())
        
    }
}

#Preview {
    LoginView()
}
