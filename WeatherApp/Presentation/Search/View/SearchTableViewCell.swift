//
//  SearchTableViewCell.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/18.
//

import UIKit

import SnapKit

final class SearchTableViewCell: UITableViewCell {
  static let identifier = "SearchTableViewCell"
  private let cityLabel = UILabel()
  private let countryLabel = UILabel()
  private let stackView = UIStackView()
  
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
    cityLabel.then {
      $0.font = .systemFont(ofSize: 20, weight: .bold)
      $0.textColor = .systemBackground
    }
    
    countryLabel.then {
      $0.font = .systemFont(ofSize: 20)
      $0.textColor = .systemBackground
    }
    
    stackView.then {
      $0.addArrangedSubviews([
        cityLabel,
        countryLabel
      ])
      $0.axis = .vertical
      $0.spacing = 16
    }
  }
  
  private func layout() {
    addSubview(stackView)
    stackView.snp.makeConstraints {
      $0.directionalEdges.equalToSuperview().inset(16)
    }
  }
}

// MARK: Binder

extension SearchTableViewCell {
  func bindView(city: City) {
    cityLabel.text = city.name
    countryLabel.text = city.country
  }
}
