//
//  LoginRequest.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 19.10.2023.
//

import Foundation



// Создайте структуру для хранения ответа сервера
struct ServerTokenResponse: Codable {
    let token: String
}

// Структура для представления данных в запросе
struct LoginRequest: Codable {
    var email: String
    var code: String
}

struct PreLoginRequest: Codable {
    var email: String
    var password: String
}
