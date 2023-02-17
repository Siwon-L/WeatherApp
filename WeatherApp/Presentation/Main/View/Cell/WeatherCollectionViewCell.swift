//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/17.
//

import UIKit

import SnapKit

final class WeatherCollectionViewCell: UICollectionViewCell {
  static let identifier = "WeatherCollectionViewCell"
  let timeLabel = UILabel()
  let weatherIconImageView = UIImageView()
  let tempLabel = UILabel()

  
  override init(frame: CGRect) {
    super.init(frame: frame)
    attribute()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func attribute() {
    timeLabel.then {
      $0.textColor = .systemBackground
      $0.font = .systemFont(ofSize: 12)
      $0.textAlignment = .center
    }
    
    tempLabel.then {
      $0.textAlignment = .center
    }
    
    tempLabel.textColor = .systemBackground
  }
  
  private func layout() {
    addSubviews([
      timeLabel,
      weatherIconImageView,
      tempLabel
    ])
    
    timeLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().inset(16)
    }
    
    weatherIconImageView.snp.makeConstraints {
      $0.height.width.equalTo(35)
      $0.center.equalToSuperview()
    }
    
    tempLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
  }
}

// MARK: Binder

extension WeatherCollectionViewCell {
  func bindView(info: ObservationInfo) {
    timeLabel.text = info.time
    weatherIconImageView.image = UIImage(named: info.icon)
    tempLabel.text = "\(Int(info.temp.rounded()))°"
  }
}
