//
//  SearchCoordinator.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/18.
//

import UIKit

final class SearchCoordinator: Coordinator {
  var navigationController: UINavigationController
  weak var parentCoordinator: Coordinator?
  var childCoordinators: [Coordinator] = []
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func makeSearchViewController() -> SearchViewController {
    
    let network = NetworkService()
    let repository = WeatherRepository(networkService: network, dateFormatter: nil)
    let useCase = WeatherUseCase(repository: repository)
    let viewModel = SearchViewModel(useCase: useCase)
    let searchViewController = SearchViewController(viewModel: viewModel)
    searchViewController.coordinator = self
    return searchViewController
  }
}
