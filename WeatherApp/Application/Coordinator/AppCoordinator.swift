//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/15.
//

import UIKit

final class AppCoordinator: Coordinator {
  let navigationController: UINavigationController
  weak var parentCoordinator: Coordinator?
  var childCoordinators: [Coordinator] = []
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let mainCoordinator = MainCoordinator(navigationController: navigationController)
    mainCoordinator.parentCoordinator = self
    childCoordinators.append(mainCoordinator)
    mainCoordinator.start()
  }
}
