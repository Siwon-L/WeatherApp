//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/17.
//

import UIKit

import SnapKit
import RxSwift

final class WeatherTableViewCell: UITableViewCell {
  static let identifier = "WeatherTableViewCell"
  private let dayLabel = UILabel()
  private let weatherIconImageView = UIImageView()
  private let minTempLabel = UILabel()
  private let maxTempLabel = UILabel()
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
    backgroundColor = .clear
    
    tempStackView.then {
      $0.addArrangedSubviews([
        minTempLabel,
        maxTempLabel
      ])
      $0.spacing = 8
    }
  }
  
  private func layout() {
    addSubviews([
      dayLabel,
      weatherIconImageView,
      tempStackView
    ])
    
    dayLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
    }
    
    tempStackView.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(20)
      $0.centerY.equalToSuperview()
    }
    
    weatherIconImageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.centerX.equalToSuperview().multipliedBy(0.7)
      $0.height.width.equalTo(35)
    }
    
    weatherIconImageView.snp.makeConstraints {
      $0.width.equalTo(weatherIconImageView.snp.height)
    }
  }
}

// MARK: Binder

extension WeatherTableViewCell {
  func bindView(info: DayWeatherInfo) {
    dayLabel.text = info.day
    weatherIconImageView.image = UIImage(named: info.icon)
    minTempLabel.text = "최소: \(Int(info.tempMin.rounded()))°"
    maxTempLabel.text = "최대: \(Int(info.tempMax.rounded()))°"
  }
}
