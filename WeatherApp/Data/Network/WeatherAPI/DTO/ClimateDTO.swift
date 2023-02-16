//
//  ClimateDTO.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

struct ClimateDTO: Codable {
  let temp: Double
  let feelsLike: Double
  let tempMin: Double
  let tempMax: Double
  let pressure: Int
  let seaLevel: Int
  let grndLevel: Int
  let humidity: Int
  let tempKf: Double
  
  private enum CodingKeys: String, CodingKey {
    case temp
    case feelsLike = "feels_like"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case pressure
    case seaLevel = "sea_level"
    case grndLevel = "grnd_level"
    case humidity
    case tempKf = "temp_kf"
  }
}
