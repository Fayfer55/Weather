//
//  HourlyForecastViewController.swift
//  Weather
//
//  Created by Kirill Faifer on 20.05.2025.
//

import UIKit

final class HourlyForecastViewController: UICollectionViewController {
    
    private(set) var hours = [Hour]()
    
    // MARK: - Lifecycle
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        super.init(collectionViewLayout: layout)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    // MARK: - Layout
    
    private func setupSubviews() {
        collectionView.register(cellType: HourlyForecastCollectionCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
}

// MARK: - Fill

extension HourlyForecastViewController {
    
    func fill(hours: [Hour]) {
        self.hours = hours
        collectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDataSource

extension HourlyForecastViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { hours.count }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HourlyForecastCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.fill(hour: hours[indexPath.item])
        return cell
    }
    
}
