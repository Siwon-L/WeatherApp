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
  
  func toDomain(dateFormatter: DateFormatter) -> WeatherInfo {
    let observationInfo = observationInfo.map { $0.toDomain(dateFormatter: dateFormatter) }
    let (max, min) = getTeamMaxAndMin(observationInfo)
    
    return WeatherInfo(
      observationInfo: observationInfo,
      city: city.toDomain(),
      teamMaxs: max,
      teamMins: min
    )
  }
  
  private func getTeamMaxAndMin(_ observationInfo: [ObservationInfo]) -> (max: [Double], min: [Double]) {
    var day = ""
    var max: [Double] = []
    var min: [Double] = []
    for _ in 0..<5 {
      guard let index = observationInfo.firstIndex(where:{ $0.day != day }) else { break }
      guard let teamMax = observationInfo.filter({ $0.day == observationInfo[index].day })
        .map({ $0.temp }).max() else { break }
      max.append(teamMax)
      guard let teamMax = observationInfo.filter({ $0.day == observationInfo[index].day })
        .map({ $0.temp }).min() else { break }
      min.append(teamMax)
      day = observationInfo[index].day
    }
    return (max, min)
  }
}
