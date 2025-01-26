//
//  WeatherModel.swift
//  Clima
//
//  Created by Omar Assidi on 09/12/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

struct WeatherModel: Decodable {
    let conditionId: Int?
    let temperature: Double
    let name: String
    var condition: WeatherCondition {
        if let conditionId = conditionId {
            switch conditionId {
            case 200...232:
                return .thunderstorm
            case 300...321:
                return .drizzle
            case 500...531:
                return .rain
            case 600...622:
                return .snow
            case 701...781:
                return .mist
            case 800:
                return .clear
            case 801...804:
                return .clouds
            default:
                return .unkown
            }
        } else {
            return .unkown
        }
    }
}



enum WeatherCondition: String {
    case thunderstorm = "cloud.bolt"
    case drizzle = "cloud.drizzle"
    case rain = "cloud.rain"
    case snow = "cloud.snow"
    case mist = "cloud.fog"
    case clear = "sun.max"
    case clouds = "cloud.sun.fill"
    case unkown = "questionmark.circle.dashed"
}
