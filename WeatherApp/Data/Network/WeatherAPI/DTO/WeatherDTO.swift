//
//  WeatherDTO.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

struct WeatherDTO: Codable {
  let id: Int
  let weatherCase: WeatherCaseDTO
  let description: String
  let icon: String
  
  private enum CodingKeys: String, CodingKey {
    case id
    case weatherCase = "main"
    case description, icon
  }
}

enum WeatherCaseDTO: String, Codable {
  case clear = "Clear"
  case clouds = "Clouds"
  case rain = "Rain"
  case snow = "Snow"
  
  func toDomain() -> WeatherCase {
    switch self {
    case .clear:
      return .clear
    case .clouds:
      return .clouds
    case .rain:
      return .rain
    case .snow:
      return .snow
    }
  }
}
