//
//  WeatherData.swift
//  Clima
//
//  Created by OmarAssidi on 20/10/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: MainWeatherData
    let weather: [Weather]
}

struct MainWeatherData: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let description: String
    let main: String
    let icon: String
    
}
