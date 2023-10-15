//
//  WeatherData.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 15.10.2023.
//

import Foundation


struct WeatherData: Codable {
    let city: String
    let temperature: Double
    let condition: String
    let base: String?
    let visibility: Int?
    let id: Int?
    let name: String?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?
    let seaLevel: Int?
    let groundLevel: Int?
    let windSpeed: Double?
    let windDeg: Int?
    let windGust: Double?
    let rain1h: Double?
    let cloudsAll: Int?
    let sunrise: Double?
    let sunset: Double?
}
