//
//  ViewControllerFactory.swift
//  Clima
//
//  Created by Omar Assidi on 28/01/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import CoreLocation

struct ViewControllerFactory {
    static func getWeatherViewController() -> WeatherViewController {
        return .init(viewModel: ViewModelFactory.getWeatherViewModel(), locationManager: CLLocationManager())
    }
}
