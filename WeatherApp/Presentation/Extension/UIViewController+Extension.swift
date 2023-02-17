//
//  UIViewController+Extension.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/18.
//

import UIKit

import RxSwift

extension UIViewController {
  var showErrorAlert: Binder<String?> {
    return Binder(self) { owner, message in
      let alert = UIAlertController.makeAlert(message: message)
      owner.present(alert, animated: true)
    }
  }
}

