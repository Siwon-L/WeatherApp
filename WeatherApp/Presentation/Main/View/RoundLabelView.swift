//
//  RoundLabelView.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/17.
//

import UIKit

import SnapKit

final class RoundLabelView: UIView {
  let infoLabel = UILabel()
  private(set) lazy var roundView = RoundView(view: infoLabel)
  
  init() {
    super.init(frame: .zero)
    attribute()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func attribute() {
    infoLabel.then {
      $0.font = .systemFont(ofSize: 30)
    }
  }
  
  private func layout() {
    addSubview(roundView)
    
    roundView.snp.makeConstraints {
      $0.directionalEdges.equalToSuperview()
    }
  }
}
