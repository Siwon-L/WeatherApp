//
//  RoundCollectionView.swift
//  WeatherApp
//
//  Created by 이시원 on 2023/02/17.
//

import UIKit

import SnapKit

final class RoundCollectionView: UIView {
  private(set) lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewCompositionalLayout(
      section: configureLayoutSection()
    )
  )
  private(set) lazy var roundView = RoundView(view: collectionView)
  
  init() {
    super.init(frame: .zero)
    attribute()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func attribute() {
    collectionView.then {
      $0.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
      $0.backgroundColor = .clear
    }
  }
  
  private func layout() {
    addSubview(roundView)
    
    roundView.snp.makeConstraints {
      $0.directionalEdges.equalToSuperview()
    }
  }
  
  private func configureLayoutSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0)
    )
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item]
    )
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuous
    return section
  }
}
