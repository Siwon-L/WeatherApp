//
//  RoundView.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/17.
//

import UIKit

import SnapKit

final class RoundView: UIView {
  let titleLabel = UILabel()
  
  init(view: UIView) {
    super.init(frame: .zero)
    attribute()
    layout(view: view)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func attribute() {
    backgroundColor = .systemGray.withAlphaComponent(0.3)
    layer.cornerRadius = 10
    
    titleLabel.then {
      $0.textColor = .systemBackground
      $0.font = .systemFont(ofSize: 12)
      $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
  }
  
  private func layout(view: UIView) {
    addSubviews([
      titleLabel,
      view
    ])
    
    titleLabel.snp.makeConstraints {
      $0.top.left.right.equalToSuperview().inset(8)
    }
    
    view.snp.makeConstraints {
      $0.bottom.left.right.equalToSuperview().inset(8)
      $0.top.equalTo(titleLabel.snp.bottom)
    }
  }
}
