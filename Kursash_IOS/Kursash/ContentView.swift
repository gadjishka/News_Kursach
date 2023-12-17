//
//  ContentView.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 16.09.2023.
//
import SwiftUI

struct ContentView: View {
    @StateObject var mainVM = MainViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if mainVM.showAuthContainer == .loading {
                    LoadingView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                mainVM.checkToken()
                            
                            }
                        }
                } else if mainVM.showAuthContainer == .show {
                    LoginView()
                } else if mainVM.showAuthContainer == .preLogin {
                    TwoAuthView()
                }
                else if mainVM.showAuthContainer == .not_show {
                    TabView {
                        WeatherView()
                            .tabItem {
                                Image(systemName: "cloud")
                                Text("Weather")
                            }
                        NasaView()
                            .tabItem {
                                Image(systemName: "cloud")
                                Text("Nasa")
                            }
                        UserProfileView()
                            .tabItem {
                                Image(systemName: "person")
                                Text("Account")
                            }
                        
                    }
                    
                }
            }
            
        }
        
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(mainVM)
        .navigationBarTitle("", displayMode: .inline)
        .preferredColorScheme(.light)
        
    }
    
}








#Preview {
    ContentView()
}
