//
//  Endpoint.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

final class Endpoint {
  enum HTTPMethod: String {
    case get = "GET"
  }
  
  private let base: String
  private let path: String
  private let method: HTTPMethod
  private let queries: [String: Any]
  
  init(
    base: String,
    path: String,
    method: HTTPMethod,
    queries: [String : Any] = [:]
  ) {
    self.base = base
    self.path = path
    self.method = method
    self.queries = queries
  }
  
  func create() throws -> URLRequest {
    let url = try createURL()
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue

    return request
  }
  
  private func createURL() throws -> URL {
    let urlString = base + path
    
    var component = URLComponents(string: urlString)
    component?.queryItems = queries.map {
      URLQueryItem(name: $0.key, value: "\($0.value)")
    }
    
    guard let url = component?.url else {
      throw HTTPError.createURLError
    }
    return url
  }
}
