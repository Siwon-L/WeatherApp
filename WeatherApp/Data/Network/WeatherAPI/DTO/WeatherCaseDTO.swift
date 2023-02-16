//
//  WeatherCaseDTO.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

enum WeatherCaseDTO: String, Codable {
  case clear = "Clear"
  case clouds = "Clouds"
  case rain = "Rain"
  case snow = "Snow"
}
