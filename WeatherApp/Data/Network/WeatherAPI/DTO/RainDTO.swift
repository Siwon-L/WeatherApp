//
//  RainDTO.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

struct RainDTO: Codable {
  let the3H: Double
  
  private enum CodingKeys: String, CodingKey {
    case the3H = "3h"
  }
}
