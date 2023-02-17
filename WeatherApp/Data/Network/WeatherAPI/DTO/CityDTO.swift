//
//  CityDTO.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/16.
//

import Foundation

struct CityDTO: Codable {
  let id: Int
  let name: String
  let coord: CoordDTO
  let country: String
  let population: Int?
  let timezone: Int?
  let sunrise: Int?
  let sunset: Int?
  
  func toDomain() -> City {
    City(
      name: name,
      country: country,
      lat: coord.lat,
      lon: coord.lon
    )
  }
}
