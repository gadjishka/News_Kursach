//
//  TokenManager.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 20.10.2023.
//

import Foundation

struct TokenRefreshResponse: Codable {
    let token: String
}

class TokenManager {
    static let tokenKey = "jwtToken"
    
    static func saveToken(token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    static func deleteToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
    
    static func loadToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }
    
    static func refreshJWTToken() {
        guard let currentToken = TokenManager.loadToken()
        else {
            print("No valid token available")
            return
        }
        
        guard let tokenURL = URL(string: APIConstants.refreshTokenUrl) else {
            print("Invalid token refresh URL")
            return
        }
        
        var request = URLRequest(url: tokenURL)
        request.httpMethod = "POST"
        request.addValue("Bearer \(currentToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let newToken = String(data: data, encoding: .utf8) {
                    TokenManager.saveToken(token: newToken)
                } else {
                    print("Failed to parse new token")
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    static func getDataFromToken() throws -> [String: Any] {
        
        let jwt = TokenManager.loadToken()!
        
        enum DecodeErrors: Error {
            case badToken
            case other
        }
        
        func base64Decode(_ base64: String) throws -> Data {
            let base64 = base64
                .replacingOccurrences(of: "-", with: "+")
                .replacingOccurrences(of: "_", with: "/")
            let padded = base64.padding(toLength: ((base64.count + 3) / 4) * 4, withPad: "=", startingAt: 0)
            guard let decoded = Data(base64Encoded: padded) else {
                throw DecodeErrors.badToken
            }
            return decoded
        }
        
        func decodeJWTPart(_ value: String) throws -> [String: Any] {
            let bodyData = try base64Decode(value)
            let json = try JSONSerialization.jsonObject(with: bodyData, options: [])
            guard let payload = json as? [String: Any] else {
                throw DecodeErrors.other
            }
            return payload
        }
        
        let segments = jwt.components(separatedBy: ".")
        return try decodeJWTPart(segments[1])
    }
    
    static func checkTokenExpire() -> TokenExpTime{
        
        guard let token = TokenManager.loadToken() else {
            return .expired
        }
        
        
        var expDate: Date?
        
        do {
            let token = try TokenManager.getDataFromToken()
            
            let expTimestamp = TimeInterval(token["exp"] as! Int) // Пример значения iat

            // Преобразование в объекты Date
            expDate = Date(timeIntervalSince1970: expTimestamp)
            
            let currentDate = Date() // Текущее время
            
            if expDate! < currentDate {
                return .expired
            } else {
                // Рассчитываем оставшееся время в днях
                let timeDifference = expDate!.timeIntervalSince(currentDate)
                let daysRemaining = Int(timeDifference / (60 * 60 * 24)) // Количество дней

                // Проверка, осталось ли больше дня или меньше
                if daysRemaining > 1 {
                    return .ok
                } else {
                    return .lessThanDay
                }
            }
            
        } catch {
            print("error")
            return .expired
        }
    }
    
    
}

enum TokenExpTime {
    case expired, lessThanDay, ok
}
