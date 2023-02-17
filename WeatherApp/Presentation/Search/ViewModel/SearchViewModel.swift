//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/18.
//

import Foundation

import RxSwift
import RxCocoa

protocol SearchViewModelInput {
  func parsingCityList()
  func searchKeyWord(_ keyWord: String)
  func selectedCity(indexPath: IndexPath)
}

protocol SearchViewModelOutput {
  var searchedList: BehaviorRelay<[City]> { get }
}

protocol SearchViewModelable: SearchViewModelInput, SearchViewModelOutput {}

final class SearchViewModel: SearchViewModelable {
  private var cityList: [City] = []
  private var useCase: WeatherUseCaseable
  let searchedList = BehaviorRelay<[City]>(value: [])
  private let disposeBag = DisposeBag()
  
  init(useCase: WeatherUseCaseable) {
    self.useCase = useCase
  }
  
  func searchKeyWord(_ keyWord: String) {
    if keyWord == "" {
      searchedList.accept(cityList)
      return
    }
    
    let newSearchedList = cityList.filter { $0.name.contains(keyWord) }
    searchedList.accept(newSearchedList)
  }
  
  func selectedCity(indexPath: IndexPath) {
    let selectedCity = searchedList.value[indexPath.row]
    NotificationCenter.default.post(
      name: .selectedCity,
      object: selectedCity
    )
  }
}

extension SearchViewModel {
  func parsingCityList() {
    useCase.parsingCityList()
      .bind(with: self) { owner, cityList in
        owner.cityList = cityList
        owner.searchedList.accept(cityList)
      }.disposed(by: disposeBag)
  }
}
