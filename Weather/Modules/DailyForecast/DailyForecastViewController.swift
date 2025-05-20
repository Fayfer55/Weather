//
//  DailyForecastViewController.swift
//  Weather
//
//  Created by Kirill Faifer on 20.05.2025.
//

import UIKit

final class DailyForecastViewController: UITableViewController {
    
    private(set) var days = [DailyForecast]()
    
    // MARK: - Lifecycle
    
    init() {
        super.init(style: .plain)
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
        tableView.alwaysBounceVertical = false
        tableView.register(cellType: DailyForecastTableCell.self)
    }
    
}

// MARK: - Fill

extension DailyForecastViewController {
    
    func fill(days: [DailyForecast]) {
        self.days = days
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource

extension DailyForecastViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { days.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DailyForecastTableCell = tableView.dequeueReusableCell(for: indexPath)
        cell.fill(forecast: days[indexPath.row])
        return cell
    }
    
}
