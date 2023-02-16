//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

struct WeatherInfo {
  let observationInfos: [ObservationInfo]
  let city: City
  let weekWeatherInfo: [DayWeatherInfo]
}
