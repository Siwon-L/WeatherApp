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
  let observationInfos: [ObservationInfoDTO]
  let city: CityDTO
  
  private enum CodingKeys: String, CodingKey {
    case cod, message, cnt, city
    case observationInfos = "list"
  }
  
  func toDomain(dateFormatter: DateFormatter) -> WeatherInfo {
    let observationInfos = observationInfos.map { $0.toDomain(dateFormatter: dateFormatter) }
    
    return WeatherInfo(
      observationInfos: observationInfos,
      city: city.toDomain(),
      weekWeatherInfo: getWeakWeatherInfo(observationInfos)
    )
  }
  
  private func getWeakWeatherInfo(_ observationInfos: [ObservationInfo]) -> [DayWeatherInfo] {
    var weekWeatherInfo: [DayWeatherInfo] = []
    for day in observationInfos.map({ $0.day }).deduplication() {
      let dayWeather = observationInfos.filter({ $0.day == day })
      guard let dayWeatherCase = dayWeather.first(where: { $0.time == "오후 12시" })?.weatherCase else { break }
      let dayTeams = dayWeather.map({ $0.temp })
      guard let dayTeamMax = dayTeams.max() else { break }
      guard let dayTeamMin = dayTeams.min() else { break }
      
      let dayWeatherInfo = DayWeatherInfo(
        day: day,
        weatherCase: dayWeatherCase,
        tempMax: dayTeamMax,
        tempMin: dayTeamMin
      )
      weekWeatherInfo.append(dayWeatherInfo)
    }
    return weekWeatherInfo
  }
}

private extension Sequence where Element: Hashable {
  func deduplication() -> [Element] {
    var set = Set<Element>()
    return filter { set.insert($0).inserted }
  }
}
