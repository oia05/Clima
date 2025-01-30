//
//  NetworkModule.swift
//  Clima
//
//  Created by Omar Assidi on 30/01/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Factory

extension Container {
    var jsonParser: Factory<JsonParser> {
        self {
            ClimaJsonParser()
        }.singleton
    }
    
    var apiService: Factory<ApiService> {
        self {
            ClimaApiService()
        }.singleton
    }
}
