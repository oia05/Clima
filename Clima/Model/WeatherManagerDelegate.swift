//
//  WeatherDelegate.swift
//  Clima
//
//  Created by Omar Assidi on 09/12/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ weatherManager: WeatherManager, error: Error)
    func didStartFetching(_ weatherManager: WeatherManager)
}
