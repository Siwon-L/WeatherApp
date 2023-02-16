//
//  WindDTO.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

struct WindDTO: Codable {
  let speed: Double
  let deg: Int
  let gust: Double
}
