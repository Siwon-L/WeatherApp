//
//  ViewController.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/15.
//

import UIKit

import SnapKit

final class MainViewController: UIViewController {
  weak var coordinator: MainCoordinator?
  private let searchBar = UISearchBar()
  private let mainView = MainView()
  
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
  
  private func layout() {
    view.addSubview(mainView)
    mainView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }
}

