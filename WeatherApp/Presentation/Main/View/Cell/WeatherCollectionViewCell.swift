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
  private let mainStackView = UIStackView()

  
  override init(frame: CGRect) {
    super.init(frame: frame)
    attribute()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func attribute() {
    mainStackView.then {
      $0.axis = .vertical
      $0.addArrangedSubviews([
        timeLabel,
        weatherIconImageView,
        tempLabel
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
