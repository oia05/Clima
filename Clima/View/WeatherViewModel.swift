//
//  WeatherManager.swift
//  Clima
//
//  Created by Omar Assidi on 05/12/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import Combine

class WeatherViewModel {
    let repository: ClimaRepositoryProtocol!
    init(repository: ClimaRepositoryProtocol) {
        self.repository = repository
    }
    private var _uiState: CurrentValueSubject = CurrentValueSubject<UiState, Never>( UiState(isLoading: true, weatherModel: nil))
    var uiState: AnyPublisher<UiState, Never> {
        _uiState.eraseToAnyPublisher()
    }
    
    
    private var _effect = PassthroughSubject<String?, Never>()
    var effect: AnyPublisher<String?, Never> {
        _effect.eraseToAnyPublisher()
    }
    
    func fetchWeather(cityName: String) {
        Task { @MainActor in 
            do {
                setState { state in
                    state.copy(isLoading: true)
                }
                let model = try await repository.fetchWeather(cityName: cityName)
                setState { state in
                    state.copy(isLoading: false, weatherModel: model)
                }
            } catch {
                setState { state in
                    state.copy(isLoading: false)
                }
                _effect.send(error.localizedDescription)
            }
        }
        
    }
    
    func fetchWeather(latitude: Double, longtitude: Double) {
      Task { @MainActor in
            do {
                setState { state in
                    state.copy(isLoading: true)
                }
                let model = try await repository.fetchWeather(latitude: latitude, longtitude: longtitude)
                setState { state in
                    state.copy(isLoading: false, weatherModel: model)
                }
            } catch {
                sendEffect(errorMessage: (error.localizedDescription))
            }
        }
    }
    
    func setState(changes: (UiState) -> UiState) {
        _uiState.send(changes(_uiState.value))
    }
    
    func sendEffect(errorMessage: String) {
        _effect.send(errorMessage)
    }
}

protocol ErrorMapper {
    func mapError(from: Data) -> LocalizedError
}

struct ClimaErrorMapper: ErrorMapper {
    func mapError(from data: Data) -> LocalizedError {
        return AppError.unkownError
    }
}


enum AppError: LocalizedError {
    case networkError
    case unkownError
    
}
