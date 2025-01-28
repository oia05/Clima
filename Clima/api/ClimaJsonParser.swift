//
//  ClimaJsonParser.swift
//  Clima
//
//  Created by Omar Assidi on 29/01/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

class ClimaJsonParser: JsonParser {
    func parse<T: Decodable>(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        let response = try decoder.decode(T.self, from: data)
        return response
    }
    
    func parse(_ data: Encodable) throws -> Data {
        let encoder = JSONEncoder()
        let response = try encoder.encode(data)
        return response
    }
}
