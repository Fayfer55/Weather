//
//  WeatherViewController.swift
//  Weather
//
//  Created by Kirill Faifer on 15.05.2025.
//

import UIKit
import SnapKit
import OSLog

final class WeatherViewController: UIViewController {
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "Weather.app", category: "ViewController")
    
    // MARK: - DI
    
    private let locationManager: LocationInterface
    private let forecastManager: ForecastNetworkInterface
    
    // MARK: - Properties
    
    private var isLoading = false {
        didSet {
            activityView.isHidden = !isLoading
            isLoading ? activityView.startAnimating() : activityView.stopAnimating()
        }
    }
    
    // MARK: - UI Elements
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.isHidden = true
        return view
    }()
    
    private lazy var currentWeatherView = CurrentWeatherView()
    
    private lazy var hourlyForecastViewController = HourlyForecastViewController()
    
    private lazy var dailyForecastViewController = DailyForecastViewController()
    
    // MARK: - Lifecycle
    
    init(locationManager: LocationInterface, forecastManager: ForecastNetworkInterface) {
        self.locationManager = locationManager
        self.forecastManager = forecastManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupSubviews()
        setupLocation()
    }
    
    // MARK: - Layout
    
    private func setupSubviews() {
        errorView.actionButton.addTarget(self, action: #selector(weatherRequest), for: .touchUpInside)
        
        addChild(hourlyForecastViewController)
        addChild(dailyForecastViewController)
        view.addSubviews(
            currentWeatherView,
            hourlyForecastViewController.view,
            dailyForecastViewController.view,
            activityView,
            errorView
        )
        
        makeConstraints()
        
        hourlyForecastViewController.didMove(toParent: self)
        dailyForecastViewController.didMove(toParent: self)
    }
    
    private func makeConstraints() {
        currentWeatherView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            $0.centerX.equalToSuperview()
        }
        hourlyForecastViewController.view.snp.makeConstraints {
            $0.top.equalTo(currentWeatherView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        dailyForecastViewController.view.snp.makeConstraints {
            $0.top.equalTo(hourlyForecastViewController.view.snp.bottom).offset(40)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        activityView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        errorView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Private Helpers
    
    private func setupLocation() {
        Task {
            await locationManager.authorizationRequest()
            
            weatherRequest()
        }
    }
    
    private func parse(weather: Weather) {
        let currentHour = Calendar.current.component(.hour, from: .now)
        let twoDaysInHours = 48
        let twoDaysForecast = weather.forecast.days.flatMap(\.hour).prefix(twoDaysInHours)
        let forecastHours = Array(twoDaysForecast.suffix(twoDaysInHours - currentHour))
        
        currentWeatherView.fill(model: .init(location: weather.location.name, temperature: weather.current.tempC))
        hourlyForecastViewController.fill(hours: forecastHours)
        dailyForecastViewController.fill(days: weather.forecast.days)
    }
    
    @objc
    private func weatherRequest() {
        Task {
            defer { isLoading = false }
            
            errorView.isHidden = true
            isLoading = true
            
            let coordinate = await locationManager.coordinate()
            
            do {
                let weather = try await forecastManager.weather(for: coordinate)
                parse(weather: weather)
            } catch {
                errorView.isHidden = false
                logger.error("\(error)")
            }
        }
    }
    
}
