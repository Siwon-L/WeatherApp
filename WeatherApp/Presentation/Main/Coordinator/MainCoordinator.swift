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
    let mainViewController = MainViewController()
    mainViewController.coordinator = self
    navigationController.pushViewController(mainViewController, animated: true)
  }
}
