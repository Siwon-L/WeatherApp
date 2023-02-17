//
//  ViewController.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/15.
//

import UIKit

import SnapKit
import RxSwift

final class MainViewController: UIViewController {
  weak var coordinator: MainCoordinator?
  private let searchBar = UISearchController()
  private let mainView = MainView()
  private let disposeBag = DisposeBag()
  private let viewModel: MainViewModelable
  private let backgroundImageView = UIImageView()
  
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
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    searchBar.then {
      $0.searchBar.placeholder = "Search"
      
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
    
  }
  
  private func bindOutput(_ viewModel: MainViewModelable) {
    viewModel.weatherInfo
      .bind(to: mainView.bindView)
      .disposed(by: disposeBag)
    
    viewModel.weatherInfo
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
      
    viewModel.errorMessage
      .bind(to: showErrorAlert)
      .disposed(by: disposeBag)
  }
}

