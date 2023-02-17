//
//  RoundTableView.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/17.
//

import UIKit

import SnapKit

final class RoundTableView: UIView {
  let tableView = UITableView()
  private(set) lazy var roundView = RoundView(view: tableView)
  
  init() {
    super.init(frame: .zero)
    attribute()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func attribute() {
    tableView.then {
      $0.isScrollEnabled = false
      $0.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
      $0.backgroundColor = .clear
    }
  }
  
  private func layout() {
    addSubview(roundView)
    
    roundView.snp.makeConstraints {
      $0.directionalEdges.equalToSuperview()
    }
  }
}
