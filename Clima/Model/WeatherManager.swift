//
//  WeatherManager.swift
//  Clima
//
//  Created by Omar Assidi on 05/12/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    var delegate: WeatherManagerDelegate?
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=74b9d9d431c55478190befba856c97a0&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(with: urlString)
        
    }
    
    func fetchWeather(latitude: Double, longtitude: Double) {
        let url = "\(weatherUrl)&lat=\(latitude)&lon=\(longtitude)"
        performRequest(with: url)
    }
    
    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let sesssion = URLSession(configuration: .default)
            let task = sesssion.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(self, error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = parseJson(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            delegate?.didStartFetching(self)
            task.resume()
        }
    }
    
    
    func parseJson(_ data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            guard let id = weatherData.weather.first?.id else { return nil }
            let name = weatherData.name
            let temp = weatherData.main.temp
            let weather = WeatherModel(conditionId: id, temperature: temp, name: name)
            return weather
        } catch {
            self.delegate?.didFailWithError(self, error: error)
            return nil
        }
    }
}

