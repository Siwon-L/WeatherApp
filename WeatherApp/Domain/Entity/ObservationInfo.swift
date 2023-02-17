//
//  ObservationInfo.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

struct ObservationInfo {
  let day: String
  let time: String
  let temp: Double
  let humidity: Int
  let weatherCase: WeatherCase
  let weatherDescription: String
  let clouds: Int
  let windSpeed: Double
  let icon: String
}

enum WeatherCase {
  case clear
  case clouds
  case rain
  case snow
  case none
}

