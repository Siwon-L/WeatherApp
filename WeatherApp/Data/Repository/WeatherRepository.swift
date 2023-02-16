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
  
  init(networkService: NetworkServiceable, decoder: JSONDecoder, dateFormatter: DateFormatter) {
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
}
