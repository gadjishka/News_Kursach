//
//  MainViewModel.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 20.10.2023.
//

import Foundation
import SwiftUI

enum ShowAuthContainer {
    case show, not_show, loading
}

class MainViewModel: ObservableObject {
    @Published var showAuthContainer: ShowAuthContainer = .loading
    @Published var token: String?
    @Published var loginPending = false
    @Published var weatherIsLoading:Loading = .notStart
    @Published var user: UserData?
    
    func checkToken() {
        if TokenManager.checkTokenExpire() != .expired {
            
            if TokenManager.checkTokenExpire() == .lessThanDay {
                TokenManager.refreshJWTToken()
                
            }
            self.token = TokenManager.loadToken()
            self.showAuthContainer = .not_show
            loadUserData()


            
        } else {
            self.showAuthContainer = .show
        }
    }
    
    func logout() {
        TokenManager.deleteToken()
        token = nil
        showAuthContainer = .show
    }
    
    // Метод для выполнения авторизации
    func login(email: String, password: String) {
        withAnimation {
            
            self.loginPending = true
            
        }
        let user = LoginRequest(email: email, password: password)
        performRequest(url: APIConstants.loginUrl, body: user) {  (result: Result<ServerTokenResponse, Error>) in
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
    
    // Метод для выполнения регистрации
    func register(firstname: String, lastname: String, email: String, password: String) {
        
        let user = RegisterRequest(firstname: firstname, lastname: lastname, email: email, password: password)
        performRequest(url: APIConstants.registerUrl, body: user) { [weak self] (result: Result<ServerTokenResponse, Error>) in
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
    private func performRequest<T: Codable>(url: String, body: T, completion: @escaping (Result<ServerTokenResponse, Error>) -> Void) {
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
                    let response = try JSONDecoder().decode(ServerTokenResponse.self, from: data)
                    completion(.success(response))
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
