//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/18.
//

import UIKit

final class SearchViewController: UIViewController {
  private let tableView = UITableView()
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
    layout()
  }
  
  private func attribute() {
    view.backgroundColor = .systemIndigo
    
  }
  
  private func layout() {

  }
}
