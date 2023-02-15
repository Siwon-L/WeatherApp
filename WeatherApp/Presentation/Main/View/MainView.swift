//
//  MainView.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/15.
//

import UIKit

import SnapKit

final class MainView: UIView {
  private let scrollView = UIScrollView()
  
  init() {
    super.init(frame: .zero)
    attribute()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func attribute() {
    scrollView.showsVerticalScrollIndicator = false
  }
  
  private func layout() {
    addSubview(scrollView)
    
    scrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
