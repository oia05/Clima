//
//  JsonParser.swift
//  Clima
//
//  Created by Omar Assidi on 29/01/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

protocol JsonParser {
    func parse<T: Decodable>(_ data: Data) throws -> T
    func parse(_ data: Encodable) throws -> Data
}
