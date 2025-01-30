//
//  ClimaApiService.swift
//  Clima
//
//  Created by Omar Assidi on 29/01/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
import Factory

class ClimaApiService: ApiService {
    @Injected(\.jsonParser)
    var jsonParser: JsonParser
    
    func performApi<T: Decodable>(endPoint: EndPoint, errorMapper: ErrorMapper) async throws -> T {
        do {
            let fullPath = endPoint.baseURL + endPoint.path
            guard let url = URL(string: fullPath) else {fatalError()}
            var component = URLComponents(url: url, resolvingAgainstBaseURL: false)
            component?.queryItems = endPoint.parameters?.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
            guard let newUrl = component?.url else  {fatalError()}
            var request = URLRequest(url: newUrl)
            request.httpMethod = endPoint.httpMethod.rawValue
            if let body = endPoint.httpBody {
                request.httpBody = try jsonParser.parse(body)
            }
            let (data, response) = try await URLSession.shared.data(for: request)
            if (response as? HTTPURLResponse)?.isSuccessfull() ?? false {
                return try jsonParser.parse(data)
            } else {
                throw errorMapper.mapError(from: data)
            }
        } catch {
            if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                throw AppError.networkError
            } else {
                throw error
            }
        }
    }
}
