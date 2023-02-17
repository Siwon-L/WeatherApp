//
//  MainCoordinator.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/15.
//

import UIKit

final class MainCoordinator: Coordinator {
  var navigationController: UINavigationController
  weak var parentCoordinator: Coordinator?
  var childCoordinators: [Coordinator] = []
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "E a h시"
    dateFormatter.locale = Locale(identifier:"ko")
    
    let network = NetworkService()
    let repository = WeatherRepository(networkService: network, dateFormatter: dateFormatter)
    let useCase = WeatherUseCase(repository: repository)
    let viewModel = MainViewModel(useCase: useCase)
    let mainViewController = MainViewController(viewModel: viewModel)
    mainViewController.coordinator = self
    navigationController.pushViewController(mainViewController, animated: true)
  }
  
  func makeSearchViewController() -> SearchViewController {
    let searchCoordinator = SearchCoordinator(navigationController: navigationController)
    childCoordinators.append(searchCoordinator)
    searchCoordinator.parentCoordinator = self
    return searchCoordinator.makeSearchViewController()
  }
}
