//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

import RxSwift

final class WeatherRepository: WeatherRepositoryable {
  private let networkService: NetworkServiceable
  private let decoder: JSONDecoder
  private let dateFormatter: DateFormatter?
  
  init(
    networkService: NetworkServiceable,
    decoder: JSONDecoder = .init(),
    dateFormatter: DateFormatter?
  ) {
    self.networkService = networkService
    self.decoder = decoder
    self.dateFormatter = dateFormatter
  }
  
  func requestWeather(lat: Double, lon: Double) -> Observable<WeatherInfo> {
    let endpoint = WeatherEndpointAPI.weather(lat: lat, lon: lon).asEndpoint
    guard let dateFormatter = dateFormatter else { return .empty() }
    
    return Single<WeatherInfo>.create { single in
      Task { [weak self] in
        guard let self = self else { return }
        do {
          let data = try await self.networkService.request(endpoint: endpoint)
          guard let weatherInfo = try? self.decoder.decode(WeatherInfoDTO.self, from: data) else {
            throw WeatherServiceError.decode(reason: .decodeFailure(WeatherInfoDTO.self))
          }
          single(.success(weatherInfo.toDomain(dateFormatter: dateFormatter)))
        } catch {
          single(.failure(error))
        }
      }
      return Disposables.create()
    }.asObservable()
  }
  
  func getCityList() -> Observable<[City]> {
    return Single<[City]>.create { [weak self] single in
      Task { [weak self] in
        guard let self = self else { return }
        do {
          let cityList = try await self.parsingCityList()
          single(.success(cityList))
        } catch {
          single(.failure(error))
        }
      }
      return Disposables.create()
    }.asObservable()
  }

  private func parsingCityList() async throws -> [City] {
    guard let path = Bundle.main.path(forResource: "citylist", ofType: "json") else {
      throw WeatherServiceError.decode(reason: .decodeFailure(WeatherInfoDTO.self))
    }
    let jsonString = try String(contentsOfFile: path)
    guard let data = jsonString.data(using: .utf8) else {
      throw WeatherServiceError.decode(reason: .decodeFailure(WeatherInfoDTO.self))
    }
    let cityList = try decoder.decode([CityDTO].self, from: data).map { $0.toDomain() }
    return cityList
  }
}
