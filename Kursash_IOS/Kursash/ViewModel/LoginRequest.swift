//
//  LoginRequest.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 19.10.2023.
//

import Foundation

let loginUrl = "http://localhost:8080/api/v1/auth/authenticate"


// Создайте структуру для хранения токена пользователя
struct UserToken {
    let token: String
}

// Глобальная переменная для хранения токена
var currentUserToken: UserToken?

// Функция для проверки токена пользователя
func checkUserToken(completion: @escaping (Bool) -> Void) {
    guard let token = currentUserToken else {
        completion(false) // Если нет сохраненного токена, считаем, что пользователь не авторизован
        return
    }

    // Создайте запрос к серверу для проверки токена
    let url = URL(string: loginUrl) // Замените на реальный URL
    var request = URLRequest(url: url!)
    request.httpMethod = "GET"
    request.setValue("Bearer \(token.token)", forHTTPHeaderField: "Authorization")

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Ошибка при проверке токена: \(error)")
            completion(false)
            return
        }

        if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            // Токен действителен, пользователь авторизован
            completion(true)
        } else {
            // Токен не действителен, пользователь не авторизован
            completion(false)
        }
    }

    task.resume()
}

// Функция для входа пользователя
func loginUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
    authenticateUser(email: email, password: password) { (authResponse, error) in
        if let error = error {
            print("Ошибка при аутентификации: \(error)")
            completion(false)
            return
        }

        if let authResponse = authResponse {
            // Аутентификация прошла успешно, сохраняем токен
            currentUserToken = UserToken(token: authResponse.token)
            completion(true)
        } else {
            // Некорректные учетные данные
            currentUserToken = nil
            completion(false)
        }
    }
}














// Структура для представления данных в запросе
struct Credentials: Codable {
    let email: String
    let password: String
}

// Создайте структуру для хранения ответа сервера
struct AuthResponse: Codable {
    let token: String
}

// Создайте функцию для отправки запроса на сервер
func authenticateUser(email: String, password: String, completion: @escaping (AuthResponse?, Error?) -> Void) {
    let url = URL(string: loginUrl) // Замените на реальный URL

    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let credentials = Credentials(email: email, password: password)
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

let getUrl = "http://localhost:8080/api/v1/demo-controller"

func getDataWithToken(token: String, completion: @escaping (Data?, Error?) -> Void) {
    let url = URL(string: getUrl ) // Замените на реальный URL вашего эндпоинта

    var request = URLRequest(url: url!)
    request.httpMethod = "GET"
    request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            completion(nil, error)
            return
        }

        if let data = data {
            completion(data, nil)
        }
    }

    task.resume()
}
