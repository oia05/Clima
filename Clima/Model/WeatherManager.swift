//
//  WeatherManager.swift
//  Clima
//
//  Created by OmarAssidi on 19/10/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    
    let apiKey = "74b9d9d431c55478190befba856c97a0"
    
    let unit = "metric"
    
    func fetchWeatherFor(city: String) {
        let url = "\(baseUrl)?q=\(city)&units=\(unit)&appid=\(apiKey)"
        performRequest(url: url)
    }
    
    private func performRequest(url: String) {
        // 1- Create URL
        guard let urlObject = URL(string: url) else {return}
        
        // 2- Create URL Session
        let session = URLSession(configuration: .default)
        
        // 3- Give the URL Session a task
        let task =  session.dataTask(with: urlObject) { data , response, error in
            
            if error != nil {
                print("Error. \(error!)")
                return
            }
            
            if let safeData = data {
                self.parseJson(data: safeData)
            }
        
            
        }
        
        // 4- Start the taks
        task.resume()
    }
    
    private func parseJson(data: Data) {
        let decoder = JSONDecoder()
        if let result = try? decoder.decode(WeatherData.self, from: data) {
            let weather = WeatherModel(cityName: result.name, conditionId: result.weather.first?.id ?? 200, temperature: result.main.temp)
            print(weather.temperatureString)
        }
    }
    
    
    
}
