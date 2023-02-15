//
//  Coordinator.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/15.
//

import UIKit

protocol Coordinator: AnyObject {
  var navigationController: UINavigationController { get }
  var parentCoordinator: Coordinator? { get set }
  var childCoordinators: [Coordinator] { get set }
}

extension Coordinator {
  func removeChildCoordinator(child: Coordinator) {
    childCoordinators.removeAll { $0 === child }
  }
}
