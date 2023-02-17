//
//  WeatherRepositoryable.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

import RxSwift

protocol WeatherRepositoryable {
  func requestWeather(lat: Double, lon: Double) -> Observable<WeatherInfo>
  func getCityList() -> Observable<[City]>
}
