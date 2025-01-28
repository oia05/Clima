//
//  ViewModelFactory.swift
//  Clima
//
//  Created by Omar Assidi on 28/01/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

struct ViewModelFactory {
    static func getWeatherViewModel() -> WeatherViewModel {
        return WeatherViewModel(repository: RepositoryFactory.getWeatherRepository())
    }
}
