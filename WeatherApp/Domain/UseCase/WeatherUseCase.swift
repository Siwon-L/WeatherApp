//
//  WeatherUseCase.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

import RxSwift

protocol WeatherUseCaseable {
  func requestWeather(lat: Double, lon: Double) -> Observable<WeatherInfo>
  func parsingCityList() -> Observable<[City]>
}

final class WeatherUseCase: WeatherUseCaseable {
  private let repository: WeatherRepositoryable
  
  init(repository: WeatherRepositoryable) {
    self.repository = repository
  }
  
  func requestWeather(lat: Double, lon: Double) -> Observable<WeatherInfo> {
    return repository.requestWeather(lat: lat, lon: lon)
  }
  
  func parsingCityList() -> Observable<[City]> {
    return repository.getCityList()
  }
}
