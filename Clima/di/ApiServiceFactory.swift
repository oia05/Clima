//
//  ApiServiceFactory.swift
//  Clima
//
//  Created by Omar Assidi on 29/01/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

struct ApiServiceFactory {
    static let service = ClimaApiService(jsonParser: JsonParserFactory.parser)
    
    
}
