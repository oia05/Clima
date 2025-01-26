//
//  WeatherData.swift
//  Clima
//
//  Created by Omar Assidi on 07/12/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    
    func mapResponse() -> WeatherModel {
        let conditionId = weather.first?.id
        return WeatherModel(conditionId: conditionId, temperature: main.temp, name: name)
    }
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}
