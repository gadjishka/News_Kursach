//
//  NasaDataViewModel.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 16.11.2023.
//

import Foundation
import SwiftUI

//enum Loading {
//    case notStart, start, end
//}

class NasaDataViewModel: ObservableObject {
    static let shared = NasaDataViewModel()
    @Published var nasaData: NasaData?
    @Published var nasaImage: UIImage?
    @Published var isLoading: Loading = .notStart
    @Published var error: String?
    
    func fetchNasaData(date: String, token: String) {
        isLoading = .start
        error = nil
        
        guard let url = URL(string: "http://localhost:8080/api/v1/nasa/\(date)") else {
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
                        let decodedData = try decoder.decode(NasaData.self, from: data)
                        self.nasaData = decodedData
                        self.fetchImage(urlString: self.nasaData!.url) { loadedImage in
                            self.nasaImage = loadedImage
                        }
                    } catch let decodingError as DecodingError {
                        print("DecodingError: \(decodingError)")
                        self.error = "Ошибка при декодировании данных"
                    } catch {
                        print("Error: \(error)")
                        self.error = "Неизвестная ошибка"
                    }
                    
                }
            }
        }
        
        task.resume()
        
    }
    
    
    func fetchImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                if let data = data, let uiImage = UIImage(data: data) {
                    completion(uiImage)
                } else {
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
}
