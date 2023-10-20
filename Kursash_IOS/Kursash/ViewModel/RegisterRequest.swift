//
//  RegisterRequest.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 19.10.2023.
//

import Foundation
//{
//    "firstname": "gadji",
//    "lastname": "gadji",
//    "email": "gadji@mail.ru",
//    "password": "123"
//}

let register_url = "http://localhost:8080/api/v1/auth/register"


// Структура для представления данных в запросе
struct RegisterRequest: Codable {
    let firstname: String
    let lastname: String
    let email: String
    let password: String
}

// Создайте структуру для хранения ответа сервера
struct RegisterResponse: Codable {
    let token: String
}

// Создайте функцию для отправки запроса на сервер
func registerUser(firstname: String, lastname: String, email: String, password: String, completion: @escaping (AuthResponse?, Error?) -> Void) {
    let url = URL(string: register_url) // Замените на реальный URL

    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let credentials = RegisterRequest(firstname: firstname, lastname: lastname, email: email, password: password)
    let jsonData = try? JSONEncoder().encode(credentials)

    request.httpBody = jsonData

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            completion(nil, error)
            return
        }

        if let data = data {
            do {
                let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                completion(authResponse, nil)
            } catch {
                completion(nil, error)
            }
        }
    }

    task.resume()
}
