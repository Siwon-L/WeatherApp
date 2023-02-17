//
//  ViewController.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/15.
//

import UIKit
import MapKit

import SnapKit
import RxSwift

final class MainViewController: UIViewController {
  weak var coordinator: MainCoordinator?
  private lazy var searchBar = UISearchController(searchResultsController: coordinator?.makeSearchViewController())
  private let mainView = MainView()
  private let disposeBag = DisposeBag()
  private let viewModel: MainViewModelable
  private let backgroundImageView = UIImageView(image: UIImage(named: "sunny"))
  
  init(viewModel: MainViewModelable) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
    layout()
    bind(viewModel)
  }
  
  private func attribute() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    searchBar.then {
      $0.searchBar.placeholder = "Search"
      $0.showsSearchResultsController = true
    }
    
    navigationItem.then {
      $0.searchController = searchBar
    }
    
    backgroundImageView.contentMode = .scaleAspectFill
  }
  
  private func layout() {
    view.addSubviews([
     backgroundImageView,
     mainView
    ])

    mainView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide)
    }
    
    backgroundImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func bind(_ viewModel: MainViewModelable) {
    bindInput(viewModel)
    bindOutput(viewModel)
  }
  
  private func bindInput(_ viewModel: MainViewModelable) {
    searchBar.searchBar.rx.text
      .bind { value in
        NotificationCenter.default.post(
          name: .searchKetWord,
          object: value
        )
      }.disposed(by: disposeBag)
    
    NotificationCenter.default.rx.notification(.selectedCity)
      .compactMap { $0.object as? City }
      .bind(with: self) { owner, city in
        owner.viewModel.inputCoordinate(lat: city.lat, lon: city.lon)
      }.disposed(by: disposeBag)
  }
  
  private func bindOutput(_ viewModel: MainViewModelable) {
    viewModel.weatherInfo
      .observe(on: MainScheduler.instance)
      .bind(to: mainView.bindView)
      .disposed(by: disposeBag)
    
    viewModel.weatherInfo
      .observe(on: MainScheduler.instance)
      .map { $0.weekWeatherInfo }
      .bind(to: mainView.weekWeatherRoundTabelView.tableView.rx.items(
        cellIdentifier: WeatherTableViewCell.identifier,
        cellType:WeatherTableViewCell.self
      )) { index, info, cell in
        var info = info
        if index == 0 { info.day = "오늘" }
        cell.bindView(info: info)
      }.disposed(by: disposeBag)
    
    viewModel.weatherInfo
      .observe(on: MainScheduler.instance)
      .map { $0.observationInfos[0..<8] }
      .bind(to: mainView.dayWeatherRoundCollectionView.collectionView.rx.items(
        cellIdentifier: WeatherCollectionViewCell.identifier,
        cellType: WeatherCollectionViewCell.self
      )) { index, info, cell in
        var info = info
        if index == 0 { info.time = "지금" }
        cell.bindView(info: info)
      }.disposed(by: disposeBag)
    
    viewModel.weatherInfo
      .observe(on: MainScheduler.instance)
      .compactMap { $0.observationInfos.first?.weatherCase }
      .bind(with: self) { owner, weatherCase in
        owner.backgroundImageView.image = UIImage(named: weatherCase.rawValue)
      }.disposed(by: disposeBag)
    
    viewModel.weatherInfo
      .observe(on: MainScheduler.instance)
      .map { $0.city }
      .bind(with: self) { owner, city in
        owner.moveLocation(lat: city.lat, lon: city.lon, delta: 10.0)
        owner.setAnnotation(lat: city.lat, lon: city.lon, cityName: city.name)
      }.disposed(by: disposeBag)
      
    viewModel.errorMessage
      .bind(to: showErrorAlert)
      .disposed(by: disposeBag)
  }
}

extension MainViewController {
  private func moveLocation(lat: Double, lon: Double, delta span: Double) {
    let location = CLLocationCoordinate2DMake(lat, lon)
    let range = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
    let region = MKCoordinateRegion(center: location, span: range)
    mainView.roundMapView.mapView.setRegion(region, animated: true)
  }
  
  private func setAnnotation(lat: Double, lon: Double, cityName: String) {
    mainView.roundMapView.mapView.removeAnnotations(mainView.roundMapView.mapView.annotations)
    let annotation = MKPointAnnotation()
    annotation.coordinate = CLLocationCoordinate2DMake(lat, lon)
    annotation.title = cityName
    mainView.roundMapView.mapView.addAnnotation(annotation)
  }
}

