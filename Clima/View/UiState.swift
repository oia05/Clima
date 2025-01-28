//
//  UiState.swift
//  Clima
//
//  Created by Omar Assidi on 25/01/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

class UiState {
    var isLoading: Bool = false
    var weatherModel: WeatherModel?
    init(isLoading: Bool, weatherModel: WeatherModel? = nil) {
        self.isLoading = isLoading
        self.weatherModel = weatherModel
    }
    
    func copy(isLoading: Bool? = nil, weatherModel: WeatherModel? = nil) -> UiState {
            return UiState(
                isLoading: isLoading ?? self.isLoading,
                weatherModel: weatherModel ?? self.weatherModel
            )
        }
    
}
extension UiState {
    func apply(block: (UiState) -> UiState) -> UiState {
        return block(self)
    }
}
