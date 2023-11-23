//
//  NasaData.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 16.11.2023.
//

import Foundation

struct NasaData: Codable {
    let copyright: String?
    let date: String
    let explanation: String
    let hdurl: String?
    let media_type: String
    let service_version: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case copyright
        case date
        case explanation
        case hdurl
        case media_type = "media_type"
        case service_version
        case title
        case url
    }
}

