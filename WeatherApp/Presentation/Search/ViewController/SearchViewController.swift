//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/18.
//

import UIKit

import RxSwift

final class SearchViewController: UIViewController {
  weak var coordinator: SearchCoordinator?
  private let tableView = UITableView()
  private let viewModel: SearchViewModelable
  private let disposeBag = DisposeBag()
  
  init(viewModel: SearchViewModelable) {
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
    view.backgroundColor = .systemIndigo
    
    tableView.then {
      $0.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
      $0.backgroundColor = .clear
    }
  }
  
  private func layout() {
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func bind(_ viewModel: SearchViewModelable) {
    bindInput(viewModel)
    bindOutput(viewModel)
  }
  
  private func bindInput(_ viewModel: SearchViewModelable) {
    viewModel.parsingCityList()
    
    tableView.rx.itemSelected
      .bind(with: self) { owner, indexPath in
        owner.viewModel.selectedCity(indexPath: indexPath)
        owner.dismiss(animated: true)
      }.disposed(by: disposeBag)
    
    NotificationCenter.default.rx.notification(.searchKetWord)
      .compactMap { $0.object as? String }
      .bind(with: self) { owner, keyWord in
        owner.viewModel.searchKeyWord(keyWord)
      }.disposed(by: disposeBag)
  }
  
  private func bindOutput(_ viewModel: SearchViewModelable) {
    viewModel.searchedList
      .observe(on: MainScheduler.instance)
      .bind(
        to: tableView.rx.items(
          cellIdentifier: SearchTableViewCell.identifier,
          cellType: SearchTableViewCell.self
        )
      ) { _, city, cell in
        cell.bindView(city: city)
      }.disposed(by: disposeBag)
  }
}
