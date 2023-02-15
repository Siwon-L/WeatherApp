//
//  ViewController.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/15.
//

import UIKit

final class MainViewController: UIViewController {
  weak var coordinator: MainCoordinator?
  private let searchBar = UISearchBar()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
  }
  
  private func attribute() {
    view.backgroundColor = .systemBackground
    
    searchBar.then {
      $0.placeholder = "Search"
    }
    
    navigationItem.then {
      $0.titleView = searchBar
    }
  }
  
}

