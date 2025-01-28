//
//  ClimaRepository.swift
//  Clima
//
//  Created by Omar Assidi on 24/01/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation


protocol ClimaRepositoryProtocol {
    func fetchWeather(cityName: String) async throws -> WeatherModel
    func fetchWeather(latitude: Double, longtitude: Double) async throws -> WeatherModel
}


class ClimaRepository: ClimaRepositoryProtocol {
    let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func fetchWeather(cityName: String) async throws -> WeatherModel {
        let data: WeatherData = try await apiService.performApi(endPoint: WeatherDataSource.getWeather(cityName: cityName), errorMapper: ClimaErrorMapper())
        return data.mapResponse()
    }
    
    func fetchWeather(latitude: Double, longtitude: Double) async throws -> WeatherModel {
        let data: WeatherData = try await apiService.performApi(endPoint: WeatherDataSource.getWeatherByCoordinate(latitude: latitude, longitude: longtitude), errorMapper: ClimaErrorMapper())
        return data.mapResponse()
    }
}
