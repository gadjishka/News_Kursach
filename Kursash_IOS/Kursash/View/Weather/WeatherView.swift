//
//  WeatherView.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 17.10.2023.
//

import SwiftUI

struct WeatherView: View {
    @State private var cityName = ""
    @StateObject private var weatherDataVM = WeatherDataViewModel()
    @EnvironmentObject var mainVM: MainViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .trailing) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 40)
                    
                    HStack {
                        TextField("City", text: $cityName)
                            .padding(.leading, 20)
                            .frame(height: 40)
                        
                        Button(action: {
                            
                            weatherDataVM.fetchWeatherData(cityName: cityName, token: mainVM.token!)
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
                    ProgressView("Loading...")
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
                            WeatherDataFieldView(title: "Temperature", value: "\(String(format: "%.1f", weatherData.temperature))°C", image: "thermometer.medium")
                            WeatherDataFieldView(title: "Условия", value: weatherData.condition, image: "")
                            WeatherDataFieldView(title: "Presure", value: "\(weatherData.pressure ?? 0) hPa", image: "drop.triangle")
                            WeatherDataFieldView(title: "Humidity", value: "\(weatherData.humidity ?? 0)%", image: "humidity.fill")
                            WeatherDataFieldView(title: "Sunrise", value:  weatherDataVM.formatTimestamp(weatherData.sunrise ?? 0), image: "sunrise")
                            WeatherDataFieldView(title: "Sunset", value: weatherDataVM.formatTimestamp(weatherData.sunset ?? 0), image: "sunset")
                            // Добавьте другие поля сюда
                        }
                        .padding(.horizontal)
                    }
                }
            }
            Spacer()
            
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            
        }
        
    }
    
    
}

#Preview {
    WeatherView()
}
