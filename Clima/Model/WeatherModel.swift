//
//  File.swift
//  Clima
//
//  Created by OmarAssidi on 20/10/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func updateWeather(_ weatherModel: WeatherModel)
    func handleError(_ error: Error)
}

struct WeatherModel {
    let cityName: String
    let conditionId: Int
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    var conditionName: String {
        get {
            switch conditionId {
            case WeatherCondition.clear.getValues():
                return WeatherCondition.clear.rawValue
            case WeatherCondition.cloud.getValues():
                return WeatherCondition.cloud.rawValue
            case WeatherCondition.thunderStorm.getValues():
                return WeatherCondition.thunderStorm.rawValue
            case WeatherCondition.drizzle.getValues():
                return WeatherCondition.drizzle.rawValue
            case WeatherCondition.rain.getValues():
                return WeatherCondition.rain.rawValue
            case WeatherCondition.snow.getValues():
                return WeatherCondition.snow.rawValue
            case WeatherCondition.fog.getValues():
                return WeatherCondition.fog.rawValue
            default:
                return "cloud"
                
            }
            
        }
    }
}

enum WeatherCondition: String {
    case thunderStorm = "cloud.bolt"
    case cloud = "cloud.fill"
    case clear = "sun.max"
    case drizzle = "cloud.drizzle"
    case rain = "cloud.rain"
    case snow = "cloud.snow"
    case fog = "cloud.fog"
    
    func getValues() -> ClosedRange<Int> {
        switch self {
        case WeatherCondition.thunderStorm:
            return 200...232
        case WeatherCondition.drizzle:
            return 300...321
        case WeatherCondition.rain:
            return  500...531
        case WeatherCondition.snow:
            return  600...622
        case WeatherCondition.fog:
            return  701...781
        case WeatherCondition.clear:
            return  800...800
        case WeatherCondition.cloud:
            return  801...804
        }
    }
}

