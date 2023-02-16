//
//  ObservationInfoDTO.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

struct ObservationInfoDTO: Codable {
  let time: Int
  let climate: ClimateDTO
  let weather: [WeatherDTO]
  let clouds: CloudsDTO
  let wind: WindDTO
  let visibility: Int
  let pop: Double
  let sys: SysDTO
  let dtTxt: String
  let rain: RainDTO?
  let snow: RainDTO?
  
  enum CodingKeys: String, CodingKey {
    case time = "dt"
    case climate = "main"
    case weather, clouds, wind, visibility, pop, sys
    case dtTxt = "dt_txt"
    case rain, snow
  }
}
