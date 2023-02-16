//
//  WeatherInfoDTO.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

struct WeatherInfoDTO: Codable {
  let cod: String
  let message: Int
  let cnt: Int
  let observationInfo: [ObservationInfoDTO]
  let city: CityDTO
  
  private enum CodingKeys: String, CodingKey {
    case cod, message, cnt, city
    case observationInfo = "list"
  }
}
