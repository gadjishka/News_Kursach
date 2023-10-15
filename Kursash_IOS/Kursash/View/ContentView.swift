//
//  ContentView.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 16.09.2023.
//
import SwiftUI

struct ContentView: View {
    @State private var cityName = ""
    @StateObject private var weatherDataVM = WeatherDataViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .trailing) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 40)
                    
                    HStack {
                        TextField("Город", text: $cityName)
                            .padding(.leading, 20)
                            .frame(height: 40)
                        
                        Button(action: {
                            weatherDataVM.fetchWeatherData(cityName: cityName)
                            cityName = ""
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.blue)
                                .frame(width: 40, height: 40)
                        }
                    }
                }
                .padding()
                .padding(.trailing, 10)
                
                if weatherDataVM.isLoading == .start {
                    ProgressView("Загрузка...")
                } else if let error = weatherDataVM.error {
                    Text(error)
                        .opacity(0.5)
                } else if weatherDataVM.isLoading == .end {
                    if let weatherData = weatherDataVM.weatherData {
                        Text(weatherData.city)
                            .font(.title)
                            .padding()
                        
                        LazyVGrid(columns: [
                            GridItem(),
                            GridItem()
                        ]) {
                            WeatherDataFieldView(title: "Температура", value: "\(String(format: "%.1f", weatherData.temperature))°C", image: "thermometer.medium")
                            WeatherDataFieldView(title: "Условия", value: weatherData.condition, image: "")
                            WeatherDataFieldView(title: "Давление", value: "\(weatherData.pressure ?? 0) hPa", image: "drop.triangle")
                            WeatherDataFieldView(title: "Влажность", value: "\(weatherData.humidity ?? 0)%", image: "humidity.fill")
                            WeatherDataFieldView(title: "Восход", value: formatTimestamp(weatherData.sunrise ?? 0), image: "sunrise")
                            WeatherDataFieldView(title: "Закат", value: formatTimestamp(weatherData.sunset ?? 0), image: "sunset")
                            // Добавьте другие поля сюда
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            
        }
        
    }
    
    private func formatTimestamp(_ timestamp: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = Date(timeIntervalSince1970: timestamp)
        return dateFormatter.string(from: date)
    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
