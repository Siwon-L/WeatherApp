//
//  NetworkService.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

protocol NetworkServiceable {
  func request(endpoint: Endpoint) async throws -> Data
}

final class NetworkService: NetworkServiceable {
  private let urlSession: URLSession

  init(urlSession: URLSession = .shared) {
    self.urlSession = urlSession
  }
  
  func request(endpoint: Endpoint) async throws -> Data {
    let urlRequest = try endpoint.create()
    let (data, response) = try await urlSession.data(for: urlRequest)
    guard let response = response as? HTTPURLResponse else {
      throw WeatherServiceError.network(reason: .invalidateResponse)
    }
    
    switch response.statusCode {
    case 200..<300: return data
    case 400: throw WeatherServiceError.network(reason: .badRequest)
    case 401: throw WeatherServiceError.network(reason:.unauthorized)
    case 404: throw WeatherServiceError.network(reason:.notFound)
    case 500: throw WeatherServiceError.network(reason:.internalServerError)
    case 503: throw WeatherServiceError.network(reason:.serviceUnavailable)
    default: throw WeatherServiceError.network(reason:.unknown)
    }
  }
}
