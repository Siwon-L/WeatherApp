//
//  UIStackView+Extension.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/17.
//

import UIKit

extension UIStackView {
  func addArrangedSubviews(_ views: [UIView]) {
    views.forEach {
      addArrangedSubview($0)
    }
  }
}
