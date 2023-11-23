//
//  RegisterRequest.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 19.10.2023.
//

import Foundation

// Структура для представления данных в запросе
struct RegisterRequest: Codable {
    let firstname: String
    let lastname: String
    let email: String
    let password: String
}
