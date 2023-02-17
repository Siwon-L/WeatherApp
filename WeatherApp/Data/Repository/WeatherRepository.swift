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
  private let dateFormatter: DateFormatter
  
  init(
    networkService: NetworkServiceable,
    decoder: JSONDecoder = .init(),
    dateFormatter: DateFormatter
  ) {
    self.networkService = networkService
    self.decoder = decoder
    self.dateFormatter = dateFormatter
  }
  
  func requestWeather(lat: Double, lon: Double) -> Observable<WeatherInfo> {
    let endpoint = WeatherEndpointAPI.weather(lat: lat, lon: lon).asEndpoint
    
    return Single<WeatherInfo>.create { single in
      Task { [weak self] in
        guard let self = self else { return }
        do {
          let data = try await self.networkService.request(endpoint: endpoint)
          guard let weatherInfo = try? self.decoder.decode(WeatherInfoDTO.self, from: data) else {
            throw WeatherServiceError.decode(reason: .decodeFailure(WeatherInfoDTO.self))
          }
          single(.success(weatherInfo.toDomain(dateFormatter: self.dateFormatter)))
        } catch {
          single(.failure(error))
        }
      }
      return Disposables.create()
    }.asObservable()
  }
  
  func parsingCityList() -> Observable<[City]> {
    return Single<[City]>.create { [weak self] single in
      guard let path = Bundle.main.path(forResource: "citylist", ofType: "json") else {
        single(.failure(WeatherServiceError.decode(reason: .decodeFailure(WeatherInfoDTO.self))))
        return Disposables.create()
      }
      
      guard let jsonString = try? String(contentsOfFile: path) else {
        single(.failure(WeatherServiceError.decode(reason: .decodeFailure(WeatherInfoDTO.self))))
        return Disposables.create()
      }
      
      guard let data = jsonString.data(using: .utf8) else {
        single(.failure(WeatherServiceError.decode(reason: .decodeFailure(WeatherInfoDTO.self))))
        return Disposables.create()
      }
      
      guard let cityList = try? self?.decoder.decode([CityDTO].self, from: data).map({ $0.toDomain() }) else {
        single(.failure(WeatherServiceError.decode(reason: .decodeFailure(WeatherInfoDTO.self))))
        return Disposables.create()
      }
      single(.success(cityList))
            
      return Disposables.create()
    }.asObservable()
  }
}
