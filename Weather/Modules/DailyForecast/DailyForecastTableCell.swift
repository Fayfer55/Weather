//
//  DailyForecastTableCell.swift
//  Weather
//
//  Created by Kirill Faifer on 20.05.2025.
//

import UIKit

final class DailyForecastTableCell: UITableViewCell, ClassIdentifiable {
    
    // MARK: - UI Elements
    
    private lazy var weekdayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [weekdayLabel, conditionLabel, minTemperatureLabel, maxTemperatureLabel])
        view.axis = .horizontal
        view.spacing = 16
        view.distribution = .fillProportionally
        view.alignment = .center
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = .safeArea
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupParentView()
        setupSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupParentView() {
        selectionStyle = .none
    }
    
    private func setupSubviews() {
        contentView.addSubview(horizontalStack)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        horizontalStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

// MARK: - Fill

extension DailyForecastTableCell {
    
    func fill(forecast: DailyForecast) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "EEE"
        
        weekdayLabel.text = formatter.string(from: forecast.date)
        conditionLabel.text = forecast.day.condition.text
        minTemperatureLabel.text = String(format: "%.0f", forecast.day.minTempC) + .degree
        maxTemperatureLabel.text = String(format: "%.0f", forecast.day.maxTempC) + .degree
    }
    
}
