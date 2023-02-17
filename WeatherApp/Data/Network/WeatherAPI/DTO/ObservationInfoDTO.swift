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
  
  private enum CodingKeys: String, CodingKey {
    case time = "dt"
    case climate = "main"
    case weather, clouds, wind, visibility, pop, sys
    case dtTxt = "dt_txt"
    case rain, snow
  }
  
  func toDomain(dateFormatter: DateFormatter) -> ObservationInfo {
    let splited = dateFormatter
      .string(from: .init(timeIntervalSince1970: TimeInterval(time)))
      .split(separator: " ")
    let day = splited[0]
    let tiem = "\(splited[1]) \(splited[2])"
    
    return ObservationInfo(
      day: String(day),
      time: String(tiem),
      temp: climate.temp,
      humidity: climate.humidity,
      weatherCase: weather.first?.weatherCase.toDomain() ?? .none,
      weatherDescription: weather.first?.description ?? "알 수 없음",
      clouds: clouds.all,
      windSpeed: wind.speed,
      icon: weather.first?.icon ?? ""
    )
  }
}
