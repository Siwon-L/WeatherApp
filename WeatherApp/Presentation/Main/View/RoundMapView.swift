//
//  RoundMapView.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/18.
//

import UIKit
import MapKit

import SnapKit

final class RoundMapView: UIView {
  let mapView = MKMapView()
  private(set) lazy var roundView = RoundView(view: mapView)
  
  init() {
    super.init(frame: .zero)
    attribute()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func attribute() {
    mapView.then {
      $0.isScrollEnabled = false
      $0.isRotateEnabled = false
      $0.isPitchEnabled = false
      $0.isZoomEnabled = false
    }
  }
  
  private func layout() {
    addSubview(roundView)
    
    roundView.snp.makeConstraints {
      $0.directionalEdges.equalToSuperview()
    }
  }
}
