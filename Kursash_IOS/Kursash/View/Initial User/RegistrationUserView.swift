//
//  RegistrationUserView.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 16.09.2023.
//

import SwiftUI

struct RegistrationUserView: View {
    
    @State private var login: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Text("Регистрация")
                .font(.largeTitle)
                .padding()
            
            TextField("Логин", text: $login)
                .textFieldStyle(.roundedBorder)
                .padding(.top, 40)
                .padding(.bottom, 10)
                .padding(.horizontal, 40)
            
            SecureField("Пароль", text: $password)
                .textFieldStyle(.roundedBorder)
                .textContentType(.password)
                .padding(.bottom, 40)
                .padding(.horizontal, 40)
            Button {
                //
            } label: {
                Text("Зарегистрироваться")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            .frame(width: 250, height: 70)
            .background(Color(red: 0.4627, green: 0.8392, blue: 1.0))
            .cornerRadius(10)
        }
        
        //            .fullScreenCover(isPresented: $showModal) {
        //                RegistrationUserView()
        //            }
    }
}

struct RegistrationUserView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationUserView()
    }
}
