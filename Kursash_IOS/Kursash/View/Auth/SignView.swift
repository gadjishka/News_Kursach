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
    let color = #colorLiteral(red: 0.5811814666, green: 0.8301858306, blue: 0.9220091105, alpha: 1)
    @EnvironmentObject
    var mainVM: MainViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(color)
            }
            .ignoresSafeArea()
            VStack(spacing: 0) {
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(10)
                    .frame(width: 200, height: 200)
                    .padding(.top, 74)
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
                        mainVM.register(firstname: firstname, lastname: lastname, email: email, password: password)
                    } label: {
                        Text("Registration")
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
                .padding(.top, 30)
                
                Spacer()
            }
            .textFieldStyle(CustomTextFieldStyle())
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .navigationBarTitle("Registration", displayMode: .inline)
        .background(Color.white.ignoresSafeArea())
        
    }
}




#Preview {
    SignView()
}
