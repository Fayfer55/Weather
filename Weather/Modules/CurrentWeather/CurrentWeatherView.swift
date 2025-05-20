//
//  CurrentWeatherView.swift
//  Weather
//
//  Created by Kirill Faifer on 21.05.2025.
//

import UIKit

final class CurrentWeatherView: UIView {
    
    // MARK: - UI Elements
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    private lazy var currentTemperatureStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [locationLabel, temperatureLabel])
        view.axis = .vertical
        view.spacing = 8
        view.alignment = .center
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupSubviews() {
        addSubview(currentTemperatureStack)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        currentTemperatureStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

// MARK: - Fill

extension CurrentWeatherView {
    
    func fill(model: CurrentWeatherModel) {
        locationLabel.text = model.location
        temperatureLabel.text = String(format: "%.0f", model.temperature) + .degree
    }
    
}
