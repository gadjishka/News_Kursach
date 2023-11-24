//
//  APIConstants.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 20.10.2023.
//

import Foundation

struct APIConstants {
    static let baseUrl = "http://localhost:8080/api/v1/auth"
    static let loginUrl =  baseUrl + "/authenticate"
    static let registerUrl = baseUrl + "/register"
    static let refreshTokenUrl = baseUrl + "/refresh"
}
