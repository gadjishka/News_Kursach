//
//  SignVieww.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 17.10.2023.
//

import SwiftUI

struct SignView: View {
    
    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var password = ""
    @State var token = ""
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 135)
                        .padding(.top, 60)
                    VStack(spacing: 0) {
                        Text("Sign up")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        HStack {
                            Text("First name")
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.top, 12)
                        
                        TextField("", text: $firstname.animation())
                            
                        
                        HStack {
                            Text("Last name")
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.top, 12)
                        
                        TextField("", text: $lastname.animation())
                            
                        HStack {
                            Text("Email")
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.top, 12)
                        
                        TextField("", text: $email.animation())
                            
                        
                        
                        HStack {
                            Text("Password")
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.top, 12)
                        SecureField("", text: $password)
                            
                        Button {
                            registerUser(firstname: firstname, lastname: lastname, email: email, password: password) { (authResponse, error) in
                                if let authResponse = authResponse {
                                    token = authResponse.token
                                    print("Успешная авторизация. Токен: \(authResponse.token)")
                                    // Здесь можно сохранить токен для будущих запросов
                                } else if let error = error {
                                    print("Ошибка при авторизации: \(error)")
                                }
                            }

                        } label: {
                            Text("Вход")
                        }
                        .padding()

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
                        }
                        .padding()
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .padding(.horizontal, 40)
                    .padding(.top, 80)
                    
                    Spacer()
                }
                .textFieldStyle(CustomTextFieldStyle())
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .navigationBarTitle("Registration", displayMode: .inline)
        .background(Color.white.ignoresSafeArea())
        
    }
}




#Preview {
    SignView()
}
