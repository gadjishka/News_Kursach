//
//  CustomTextFieldStyle.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 19.10.2023.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .autocapitalization(.none)
            .foregroundColor(.black)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 1)
                .opacity(0.5))
            .padding(.top, 4)
    }
}
