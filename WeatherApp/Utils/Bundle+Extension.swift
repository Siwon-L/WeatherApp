//
//  Bundle+Extension.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

extension Bundle {
  var apiKey: String {
    guard let file = self.path(forResource: "WeatherAPIInfo", ofType: "plist") else {
      return ""
    }
    
    guard let url = URL(string: file) else {
      return ""
    }
    
    guard let resource = try? NSDictionary(contentsOf: url, error: ()) else {
      return ""
    }
    
    guard let key = resource["API_KEY"] as? String else {
      return ""
    }
    return key
  }
}
