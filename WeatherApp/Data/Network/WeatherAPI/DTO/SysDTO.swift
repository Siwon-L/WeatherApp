//
//  SysDTO.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

struct SysDTO: Codable {
  let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}
