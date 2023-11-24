//
//  WeatherDataViewModel.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 15.10.2023.
//

import Foundation
import SwiftUI

enum Loading {
    case notStart, start, end
}

class WeatherDataViewModel: ObservableObject {
    static let shared = WeatherDataViewModel()
    @Published var weatherData: WeatherData?
    @Published var isLoading: Loading = .notStart
    @Published var error: String?
    
    func fetchWeatherData(cityName: String, token: String) {
        isLoading = .start
        error = nil
        
        guard let url = URL(string: "http://localhost:8080/api/v1/weather/city/\(cityName)") else {
            error = "Неверный URL"
            isLoading = .notStart
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                self.isLoading = .end
                if let error = error {
                    self.error = "Ошибка при получении данных: \(error.localizedDescription)"
                    return
                }
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(WeatherData.self, from: data)
                        self.weatherData = decodedData
                    } catch {
                        self.error = "Ошибка при декодировании данных: \(error.localizedDescription)"
                    }
                }
            }
        }
        
        task.resume()
        
    }
    
    
    func formatTimestamp(_ timestamp: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = Date(timeIntervalSince1970: timestamp)
        return dateFormatter.string(from: date)
    }
}
