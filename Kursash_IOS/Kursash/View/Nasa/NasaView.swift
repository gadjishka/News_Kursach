//
//  NasaView.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 16.11.2023.
//

import SwiftUI


struct NasaView: View {
    @State private var date = ""
    @StateObject private var nasaDataVM = NasaDataViewModel()
    @EnvironmentObject var mainVM: MainViewModel
    @State private var isDatePickerVisible = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    nasaDataVM.fetchNasaData(date: "today", token: mainVM.token!)
                } label: {
                    Text("Get image of the day")
                        .foregroundStyle(.white)
                }
                .padding()
                .background(Color(red: 0.23, green: 0.64, blue: 0.82))
                .cornerRadius(10)
                
                Button {
                    self.isDatePickerVisible.toggle()
                    
                } label: {
                    Text("Get image of the date")
                        .foregroundStyle(.white)
                }
                .padding()
                .background(Color(red: 0.23, green: 0.64, blue: 0.82))
                .cornerRadius(10)
                
                .sheet(isPresented: $isDatePickerVisible, content: {
                    DatePickerNasa(date: $date, viewModel: nasaDataVM)
                })
            }
            
            ScrollView {
                if nasaDataVM.isLoading == .start {
                    ProgressView("Loading...")
                } else if let error = nasaDataVM.error {
                    Text(error)
                        .opacity(0.5)
                } else if nasaDataVM.isLoading == .end {
                    if let nasaData = nasaDataVM.nasaData {
                        NasaDetailView(nasaData: nasaData, viewModel: nasaDataVM)
                    } else {
                        Text("Error loading NASA data")
                    }
                }
                
                
            }
        }
    }
}


struct NasaDetailView: View {
    let nasaData: NasaData
    @ObservedObject var viewModel: NasaDataViewModel
    
    var body: some View {
        VStack {
            
            Text(nasaData.title)
                .font(.title)
            
            VStack(alignment: .trailing) {
                if nasaData.url.contains("youtube") {
                    
                    if let videoID = extractYouTubeVideoID(from: nasaData.url) {
                        YouTubePlayerView(videoID: videoID)
                            .frame(height: 300)
                            .padding(5)
                    }

                }
                else {
                    NasaImageView(url: nasaData.url, viewModel: viewModel)
                }
               
                    
                
                Text(nasaData.date)
                    .padding(5)
                    .opacity(0.5)
            }
            
            Text(nasaData.explanation)
                .padding(5)
            
        }
    }
    
    
    func extractYouTubeVideoID(from url: String) -> String? {
        guard let url = URL(string: url) else { return nil }

        if let lastPathComponent = url.lastPathComponent.components(separatedBy: "?").first {
            return lastPathComponent
        }

        return nil
    }
}

struct NasaImageView: View {
    let url: String
    @ObservedObject var viewModel: NasaDataViewModel
    @State private var image: UIImage? = nil
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .padding(5)
        } else {
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.3))
                .frame(height: 300) // Задайте размеры по вашему выбору
                .cornerRadius(10)
                .padding(5)
                .onAppear {
                    viewModel.fetchImage(urlString: url) { loadedImage in
                        self.image = loadedImage
                    }
                }
         
                
                .overlay {
                    ProgressView()
                }
        }
    }
}

struct DatePickerNasa: View {
    @Binding var date: String
    @State private var selectedDate = Date()
    @ObservedObject var viewModel: NasaDataViewModel
    @EnvironmentObject var mainVM: MainViewModel
    
    var body: some View {
        DatePicker("Выберите дату", selection: $selectedDate, in: ...Date(), displayedComponents: [.date])
            .datePickerStyle(GraphicalDatePickerStyle())
            .labelsHidden()
            .padding()
            .onChange(of: selectedDate) { newDate in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "Y-M-d"
                let formattedDate = dateFormatter.string(from: newDate)
                date = formattedDate
            }
            .onDisappear {
                viewModel.fetchNasaData(date: date, token: mainVM.token!)
            }
    }
}


#Preview {
    NasaView()
}
