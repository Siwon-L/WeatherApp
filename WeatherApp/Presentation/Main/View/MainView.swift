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
  private let cityNameLabel = UILabel()
  private let tempLabel = UILabel()
  private let waetherCaseLabel = UILabel()
  private let maxAndMinTempLable = UILabel()
  private let mainInfoStackView = UIStackView()
  private let detailVerticalStackView = UIStackView()
  private let detailHorizontalFristStackView = UIStackView()
  private let detailHorizontalSecondStackView = UIStackView()
  
  private let humidityRoundView = RoundLabelView()
  private let cloudsRoundView = RoundLabelView()
  private let windRoundView = RoundLabelView()
  private let emptyRoundView = RoundView(view: UIView())
  private let weekWeatherRoundTabelView = RoundTableView()
  private let dayWeatherRoundCollectionView = RoundCollectionView()

  
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
    
    cityNameLabel.then {
      $0.textAlignment = .center
      $0.font = .systemFont(ofSize: 40, weight: .regular)
      $0.text = "Seoul"
    }
    
    tempLabel.then {
      $0.textAlignment = .center
      $0.font = .systemFont(ofSize: 100, weight: .medium)
      $0.text = "-7°"
    }
    
    waetherCaseLabel.then {
      $0.textAlignment = .center
      $0.font = .systemFont(ofSize: 30, weight: .light)
      $0.text = "맑음"
    }
    
    maxAndMinTempLable.then {
      $0.textAlignment = .center
      $0.font = .systemFont(ofSize: 20, weight: .light)
      $0.text = "최고: -1°  |  최저: -11°"
    }
    
    mainInfoStackView.then {
      $0.addArrangedSubviews([
        cityNameLabel,
        tempLabel,
        waetherCaseLabel,
        maxAndMinTempLable
      ])
      $0.axis = .vertical
      $0.spacing = 5
    }
    
    humidityRoundView.then {
      $0.roundView.titleLabel.text = "습도"
      $0.infoLabel.text = "50%"
    }
    
    cloudsRoundView.then {
      $0.roundView.titleLabel.text = "구름"
      $0.infoLabel.text = "50%"
    }
    
    windRoundView.then {
      $0.roundView.titleLabel.text = "바람 속도"
      $0.infoLabel.text = "50%"
    }
    
    detailVerticalStackView.then {
      $0.addArrangedSubviews([
        detailHorizontalFristStackView,
        detailHorizontalSecondStackView
      ])
      $0.axis = .vertical
      $0.distribution = .fillEqually
      $0.spacing = 16
    }
    
    detailHorizontalFristStackView.then {
      $0.addArrangedSubviews([
        humidityRoundView,
        cloudsRoundView
      ])
      $0.distribution = .fillEqually
      $0.spacing = 16
    }
    
    detailHorizontalSecondStackView.then {
      $0.addArrangedSubviews([
        windRoundView,
        emptyRoundView
      ])
      $0.distribution = .fillEqually
      $0.spacing = 16
    }
    
    weekWeatherRoundTabelView.then {
      $0.roundView.titleLabel.text = "5일간의 일기예보"
    }
    
    dayWeatherRoundCollectionView.then {
      $0.roundView.titleLabel.text = "시간별 일기예보"
    }
  }
  
  private func layout() {
    addSubview(scrollView)
    
    scrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    scrollView.addSubviews([
      mainInfoStackView,
      dayWeatherRoundCollectionView,
      weekWeatherRoundTabelView,
      detailVerticalStackView
    ])
    
    mainInfoStackView.snp.makeConstraints {
      $0.width.equalToSuperview()
      $0.top.equalToSuperview()
      $0.centerX.equalToSuperview()
    }
    
    dayWeatherRoundCollectionView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(mainInfoStackView.snp.bottom).offset(16)
      $0.width.equalToSuperview().inset(16)
      $0.height.equalTo(dayWeatherRoundCollectionView.snp.width).multipliedBy(0.35)
    }
    
    weekWeatherRoundTabelView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(dayWeatherRoundCollectionView.snp.bottom).offset(16)
      $0.width.equalToSuperview().inset(16)
    }
    
    detailVerticalStackView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.width.equalToSuperview().inset(16)
      $0.top.equalTo(weekWeatherRoundTabelView.snp.bottom).offset(16)
      $0.bottom.equalToSuperview()
      $0.height.equalTo(detailVerticalStackView.snp.width)
    }
  }
}
