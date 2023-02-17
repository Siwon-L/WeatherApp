//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/17.
//

import Foundation

import RxSwift
import RxCocoa

protocol MainViewModelInput {
  
}

protocol MainViewModelOutput {
  var weatherInfo: PublishRelay<WeatherInfo> { get }
  var errorMessage: PublishRelay<String?> { get }
}

protocol MainViewModelable: MainViewModelInput, MainViewModelOutput {
  var useCase: WeatherUseCaseable { get }
  
}

final class MainViewModel: MainViewModelable {
  var useCase: WeatherUseCaseable
  let errorMessage = PublishRelay<String?>()
  let weatherInfo = PublishRelay<WeatherInfo>()
  private let disposeBag = DisposeBag()
  private let coordinate = BehaviorRelay<(lat: Double, lon: Double)>(value: (36.783611, 127.004173))
  
  init(useCase: WeatherUseCaseable) {
    self.useCase = useCase
    requestWeatherInfo()
  }
}

extension MainViewModel {
  private func requestWeatherInfo() {
    coordinate
      .withUnretained(self)
      .flatMap { owner, coordinate in
        owner.useCase.requestWeather(lat: coordinate.lat, lon: coordinate.lon)
      }.catch { [weak self] error in
        guard let error = error as? WeatherServiceError else { return .empty() }
        self?.errorMessage.accept(error.failureReason)
        return .empty()
      }.bind(with: self) { owner, info in
        owner.weatherInfo.accept(info)
      }.disposed(by: disposeBag)
  }
}
