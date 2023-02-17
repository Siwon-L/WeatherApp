//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/17.
//

import UIKit

import SnapKit

final class WeatherTableViewCell: UITableViewCell {
  static let identifier = "WeatherTableViewCell"
  let dayLabel = UILabel()
  let weatherIconImageView = UIImageView()
  let minTempLabel = UILabel()
  let maxTempLabel = UILabel()
  private let mainStackView = UIStackView()
  private let tempStackView = UIStackView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func attribute() {
    dayLabel.then {
      $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    tempStackView.then {
      $0.addArrangedSubviews([
        minTempLabel,
        maxTempLabel
      ])
      $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    mainStackView.then {
      $0.addArrangedSubviews([
        dayLabel,
        weatherIconImageView,
        tempStackView
      ])
    }
  }
  
  private func layout() {
    addSubview(mainStackView)
    
    mainStackView.snp.makeConstraints {
      $0.directionalEdges.equalToSuperview()
    }
  }
}
