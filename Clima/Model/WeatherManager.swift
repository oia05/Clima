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
    
    let lat = "lat"
    
    let lon = "lon"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeatherFor(city: String) {
        let url = "\(baseUrl)?q=\(city)&units=\(unit)&appid=\(apiKey)"
        performRequest(url)
    }
    
    func fetchWeatherBy(lat: Double, lon: Double) {
        let url = "\(baseUrl)?lat=\(lat)&lon=\(lon)&units=\(unit)&appid=\(apiKey)"
        performRequest(url)
    }
    
    private func performRequest(_ url: String) {
        // 1- Create URL
        guard let urlObject = URL(string: url) else {return}
        
        // 2- Create URL Session
        let session = URLSession(configuration: .default)
        
        // 3- Give the URL Session a task
        let task =  session.dataTask(with: urlObject) { data , response, error in
            
            if error != nil {
                delegate?.handleError(error!)
                return
            }
            
            if let safeData = data {
                if let weather = self.parseJson(safeData) {
                   delegate?.updateWeather(weather)
                }
            }
        
            
        }
        
        // 4- Start the taks
        task.resume()
    }
    
    private func parseJson(_ data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
             let result = try decoder.decode(WeatherData.self, from: data)
            let weather = WeatherModel(cityName: result.name, conditionId: result.weather.first?.id ?? 200, temperature: result.main.temp)
            return weather
            
        } catch {
            delegate?.handleError(error)
            return nil
        }
       
    }
    
    
    
}
