//
//  WeatherEndpointAPI.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

enum WeatherEndpointAPI {
  private var baseURL: String {
    "https://api.openweathermap.org"
  }
  
  case weather(
    lat: Double,
    lon: Double
  )
  
  var asEndpoint: Endpoint {
    switch self {
    case .weather(let lat, let lon):
      return Endpoint(
        base: baseURL,
        path: "/data/2.5/forecast",
        method: .get,
        queries: [
          "lat": lat,
          "lon": lon,
          "appid": Bundle.main.apiKey,
          "units": "metric",
          "lang": "kr"
        ]
      )
    }
  }
}
