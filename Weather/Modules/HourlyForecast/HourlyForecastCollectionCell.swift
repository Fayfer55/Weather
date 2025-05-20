//
//  HourlyForecastCollectionCell.swift
//  Weather
//
//  Created by Kirill Faifer on 20.05.2025.
//

import UIKit

final class HourlyForecastCollectionCell: UICollectionViewCell, ClassIdentifiable {
    
    // MARK: - UI Elements
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [timeLabel, temperatureLabel])
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 16
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = .safeArea
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupParentView()
        setupSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupParentView() {
        contentView.layer.cornerRadius = 16
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 2
    }
    
    private func setupSubviews() {
        contentView.addSubview(verticalStack)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        verticalStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

// MARK: - Fill

extension HourlyForecastCollectionCell {
    
    func fill(hour: Hour) {
        timeLabel.text = hour.time.formatted(date: .omitted, time: .shortened)
        temperatureLabel.text = String(format: "%.0f", hour.tempC) + .degree
    }
    
}
