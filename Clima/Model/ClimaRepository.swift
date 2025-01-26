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
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=74b9d9d431c55478190befba856c97a0&units=metric"
    
    func fetchWeather(cityName: String) async throws -> WeatherModel {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        if let url = URL(string: urlString) {
            let data: WeatherData = try await request(url: url, errorMapper: ClimaErrorMapper())
            return data.mapResponse()
        } else {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
    }
    
    func fetchWeather(latitude: Double, longtitude: Double) async throws -> WeatherModel {
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(longtitude)"
        if let url = URL(string: urlString) {
            let data: WeatherData = try await request(url: url, errorMapper: ClimaErrorMapper())
            return data.mapResponse()
        } else {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
    }
    
    private func parseJson<T: Decodable>(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        let response = try decoder.decode(T.self, from: data)
        return response
    }
    
    func request<T: Decodable>(url: URL, errorMapper: ErrorMapper) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if (response as? HTTPURLResponse)?.isSuccessfull() ?? false {
                return try parseJson(data)
            } else {
                throw errorMapper.mapError(from: data)
            }
        } catch {
            if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                throw AppError.networkError
            } else {
                throw error
            }
        }
    }
}

extension HTTPURLResponse {
    func isSuccessfull() -> Bool {
        return (statusCode >= 200 && statusCode < 300)
    }
}
