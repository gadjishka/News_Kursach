//
//  LoginView.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 17.10.2023.
//

import SwiftUI

struct LoginView: View {
    @State var login = ""
    @State var password = ""
    @State private var token = ""
    let color = #colorLiteral(red: 0.5811814666, green: 0.8301858306, blue: 0.9220091105, alpha: 1)
    @EnvironmentObject var mainVM: MainViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(color)
            }
            .ignoresSafeArea()
            VStack {
                
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

                        if mainVM.loginPending {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                .scaleEffect(1.2)
                                .padding(.top, 26)
                        } else {
                            Button {
                                mainVM.preLogin(email: login, password: password)
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
                        }
                        
                        NavigationLink(destination: SignView()) {
                            Text("Register")
                                .fontWeight(.bold)
                        }
                        .padding(.top, 12)
                        
                        
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
