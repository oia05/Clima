//
//  ClimaDataSource.swift
//  Clima
//
//  Created by Omar Assidi on 28/01/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

protocol EndPoint {
    var header: [String: String] { get }
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var httpBody: Encodable? { get }
}
enum WeatherDataSource {
    case getWeather(cityName: String)
    case getWeatherByCoordinate(latitude: Double, longitude: Double)
}
extension WeatherDataSource: EndPoint {
    var httpBody: (any Encodable)? {
        nil
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getWeather(let cityName):
            ["q": cityName, "appid": "74b9d9d431c55478190befba856c97a0", "units": "metric"]
        case .getWeatherByCoordinate(let latitude, let longitude):
            ["lat": latitude, "lon": longitude, "appid": "74b9d9d431c55478190befba856c97a0", "units": "metric"]
        }
    }
    
    var header: [String: String] {
        return [:]
    }
    
    var baseURL: String {
        let urlString = "https://api.openweathermap.org/data/2.5/weather"
        return urlString
    }
    
    var path: String {
        return ""
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getWeather, .getWeatherByCoordinate:
            return .get
        }
        
    }
}
