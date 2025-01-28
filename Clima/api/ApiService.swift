//
//  ApiService.swift
//  Clima
//
//  Created by Omar Assidi on 28/01/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    func isSuccessfull() -> Bool {
        return (statusCode >= 200 && statusCode < 300)
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
protocol ApiService {
    func performApi<T: Decodable>(endPoint: EndPoint, errorMapper: ErrorMapper) async throws -> T
}
