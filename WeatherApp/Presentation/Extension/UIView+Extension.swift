//
//  UIView+Extension.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/17.
//

import UIKit

extension UIView {
  func addSubviews(_ views: [UIView]) {
    views.forEach {
      addSubview($0)
    }
  }
}
