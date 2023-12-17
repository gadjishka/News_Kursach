//
//  MainViewModel.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 20.10.2023.
//

import Foundation
import SwiftUI

enum ShowAuthContainer {
    case show, not_show, loading, preLogin
}

class MainViewModel: ObservableObject {
    @Published var showAuthContainer: ShowAuthContainer = .loading
    @Published var token: String?
    @Published var loginPending = false
    @Published var weatherIsLoading:Loading = .notStart
    @Published var user: UserData?
    @Published var userEmail: String?
    
    func checkToken() {
        if TokenManager.checkTokenExpire() != .expired {
            
            if TokenManager.checkTokenExpire() == .lessThanDay {
                TokenManager.refreshJWTToken()
                
            }
            self.token = TokenManager.loadToken()
            DispatchQueue.main.async {
                self.showAuthContainer = .not_show
            }
            
            loadUserData()


            
        } else {
            DispatchQueue.main.async {
                self.showAuthContainer = .show
            }
        }
    }
    
    func logout() {
        TokenManager.deleteToken()
        token = nil
        DispatchQueue.main.async {
            self.showAuthContainer = .show
        }
    }
    
    // Метод для выполнения авторизации
    func login(code: String) {
        withAnimation {
            
            self.loginPending = true
            
        }
        let user = LoginRequest(email: self.userEmail!, code: code)
        performRequest(url: APIConstants.loginUrl, body: user, responseType: ServerTokenResponse.self) {  (result: Result<ServerTokenResponse, Error>) in
            withAnimation {
                DispatchQueue.main.async {
                    self.loginPending = false
                }
            }
            
            switch result {
            case .success(let authResponse):
                self.handleAuthenticationSuccess(token: authResponse.token)
            case .failure(let error):
                print("Ошибка при авторизации: \(error)")
            }
        }
    }
    
    
    
    func preLogin(email: String, password: String) {
        let user = PreLoginRequest(email: email, password: password)
        performRequest(url: APIConstants.preLoginUrl, body: user, responseType: String.self) { (result: Result<String, Error>) in
            withAnimation {
                DispatchQueue.main.async {
                    self.loginPending = false
                }
            }
            
            switch result {
            case .success(let _):
                DispatchQueue.main.async {
                    self.showAuthContainer = .preLogin
                    self.userEmail = email
                }
                
            case .failure(let error):
                print("Ошибка при авторизации: \(error)")
            }
        }
    }

    
    
    // Метод для выполнения регистрации
    func register(firstname: String, lastname: String, email: String, password: String) {
        
        let user = RegisterRequest(firstname: firstname, lastname: lastname, email: email, password: password)
        performRequest(url: APIConstants.registerUrl, body: user, responseType: ServerTokenResponse.self) { [weak self] (result: Result<ServerTokenResponse, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let authResponse):
                self.handleAuthenticationSuccess(token: authResponse.token)
            case .failure(let error):
                print("Ошибка при регистрации: \(error)")
            }
        }
    }
    
    // Обработка успешной аутентификации
    private func handleAuthenticationSuccess(token: String) {
        DispatchQueue.main.async {
            TokenManager.saveToken(token: token)
            print("Успешная аутентификация. Токен: \(token)")
            self.token = token
            self.showAuthContainer = .not_show
            self.loadUserData()
        }
    }
    
    // Общий метод для выполнения запросов
    private func performRequest<T: Codable, U: Codable>(url: String, body: T, responseType: U.Type, completion: @escaping (Result<U, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(body)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    if U.self == String.self {
                        // Если тип ответа - строка, возвращаем ее напрямую
                        if let stringResponse = String(data: data, encoding: .utf8) as? U {
                            completion(.success(stringResponse))
                        } else {
                            completion(.failure(NSError(domain: "Invalid response type", code: 0, userInfo: nil)))
                        }
                    } else {
                        // Если тип ответа - структура, декодируем в соответствующий тип
                        let response = try JSONDecoder().decode(U.self, from: data)
                        completion(.success(response))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    
    private func loadUserData() {
        
        
        do {
            let token = try TokenManager.getDataFromToken()
            
            self.user = UserData(firstname: token["firstname"] as! String, lastname: token["lastname"] as! String, email: token["sub"] as! String)
            
        } catch {
            print("error")
        }
        
    }
    
}
