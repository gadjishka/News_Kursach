//
//  IdentifiableAlert.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 20.10.2023.
//

import Foundation
import SwiftUI

struct test2: View {
    @State private var selectedDate = Date()
    @State private var isDatePickerVisible = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.isDatePickerVisible.toggle()
            }) {
                Text("Выбрать дату")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .sheet(isPresented: $isDatePickerVisible, content: {
                DatePicker("Выберите дату", selection: $selectedDate, in: ...Date(), displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
                    .padding()
                    .onChange(of: selectedDate) { newDate in
                        // Здесь вы можете обработать выбранную дату, например, преобразовать ее в нужный формат
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "Y-M-d"
                        let formattedDate = dateFormatter.string(from: newDate)
                        print("Выбранная дата: \(formattedDate)")
                    }
            })
        }
        .padding()
    }
}

#Preview {
    test2()
}
