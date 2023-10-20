//
//  ContentView.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 16.09.2023.
//
import SwiftUI

struct ContentView: View {
    @State var authenticated = false
    @State var isCheckingAuthentication = true // Добавляем состояние для отображения прогресса проверки аутентификации

    var body: some View {
        NavigationView {
            if isCheckingAuthentication {
                // Отображаем индикатор загрузки, пока идет проверка аутентификации
                ProgressView("Checking Authentication...")
            } else if authenticated {
                WeatherView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            // Проверяем аутентификацию пользователя при появлении экрана
            checkAuthentication()
        }
    }

    func checkAuthentication() {
        // Здесь вызываем функцию authenticateUser для проверки аутентификации
        authenticateUser(email: "gadji@mail.ru", password: "123") { authResponse, error in
            if let _ = authResponse {
                // Аутентификация успешна, устанавливаем authenticated в true
                authenticated = true
            } else if let error = error {
                // Произошла ошибка при аутентификации, можно обработать ее
                print("Authentication Error: \(error.localizedDescription)")
            }
            
            // Завершаем процесс проверки аутентификации
            isCheckingAuthentication = false
        }
    }
}








#Preview {
    ContentView()
}
