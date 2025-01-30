//
//  RepositoryFactory.swift
//  Clima
//
//  Created by Omar Assidi on 28/01/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Factory

extension Container {
    var WeatherRepository: Factory<ClimaRepositoryProtocol> {
        self {
            ClimaRepository()
        }
    }
}
