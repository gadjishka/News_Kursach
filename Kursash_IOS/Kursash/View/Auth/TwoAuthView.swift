//
//  TwoAuthView.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 17.12.2023.
//

import SwiftUI

struct TwoAuthView: View {
    let color = #colorLiteral(red: 0.5811814666, green: 0.8301858306, blue: 0.9220091105, alpha: 1)
    @FocusState private var focusedField: Int?
    
    @State private var digit1: String = ""
    @State private var digit2: String = ""
    @State private var digit3: String = ""
    @State private var digit4: String = ""
    
    @EnvironmentObject var mainVM: MainViewModel
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(color)
            }
            .ignoresSafeArea()
            
            
            VStack {
                Spacer()
                Text("Введите код двухфакторной авторизации")
                    .font(.title2)
                HStack(spacing: 10) {
                    DigitTextField(text: $digit1, tag: 0, focusedField: _focusedField)
                    DigitTextField(text: $digit2, tag: 1, focusedField: _focusedField)
                    DigitTextField(text: $digit3, tag: 2, focusedField: _focusedField)
                    DigitTextField(text: $digit4, tag: 3, focusedField: _focusedField)
                }
                .padding()
                
                Button(action: {
                    let verificationCode = "\(digit1)\(digit2)\(digit3)\(digit4)"
                    print(verificationCode)
                    mainVM.login(code: verificationCode)
                }) {
                    Text("Подтвердить")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
                
                Spacer()
            }
            .padding()
            
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    
}

struct DigitTextField: View {
    @Binding var text: String
    var tag: Int
    @FocusState var focusedField: Int?
    
    var body: some View {
        TextField("", text: $text)
            .font(.system(size: 20))
            .frame(width: 50, height: 50)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .background(RoundedRectangle(cornerRadius: 8).stroke())
            .onChange(of: text) { newValue in
                if newValue.count > 1 {
                    text = String(newValue.prefix(1))
                }
            }
    }
}

#Preview {
    TwoAuthView()
}
