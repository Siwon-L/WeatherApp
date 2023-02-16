//
//  HTTPError.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

enum HTTPError: LocalizedError {
  case createURLError
  
  var errorDescription: String? {
    switch self {
    case .createURLError:
      return "URL 생성에 실패했습니다."
    }
  }
}
