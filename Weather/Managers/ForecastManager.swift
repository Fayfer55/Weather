//
//  ForecastManager.swift
//  Weather
//
//  Created by Kirill Faifer on 20.05.2025.
//

import Foundation
import CoreLocation.CLLocation
import OSLog

actor ForecastManager: ForecastNetworkInterface {
    
    let decodeManager: DecodeManagerInterace
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "Weather.app", category: "Forecast Manager")
    
    // MARK: - Init
    
    init(decodeManager: DecodeManagerInterace) {
        self.decodeManager = decodeManager
    }
    
    // MARK: - Helpers
    
    func weather(for coordinate: CLLocationCoordinate2D?) async throws -> Weather {
        let url = try configureURL(for: coordinate)
        return try await request(for: url)
    }
    
    // MARK: - Private Helpers
    
    private func request<T: Decodable>(for url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        
        logger.debug("requested for URL: \(url.absoluteString)")
        logger.debug("setted short timeout interval - 10 seconds")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        try handle(response: response)
        return try decodeManager.decode(data: data)
    }
    
    private func handle(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            logger.error("Bad Server Response Error")
            throw URLError(.badServerResponse)
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            logger.error("Network Error – \(httpResponse.statusCode)")
            throw URLError(_nsError: .init(domain: "Network Error", code: httpResponse.statusCode))
        }
    }
    
    private func configureURL(for coordinate: CLLocationCoordinate2D?) throws -> URL {
        let url: URL?
        
        if let coordinate {
            url = URL(string: "http://api.weatherapi.com/v1/forecast.json?key=fa8b3df74d4042b9aa7135114252304&q=\(coordinate.latitude),\(coordinate.longitude)&days=4")
        } else {
            url = URL(string: "http://api.weatherapi.com/v1/forecast.json?key=fa8b3df74d4042b9aa7135114252304&q=Moscow&days=4")
        }
        guard let url else { throw URLError(.badURL) }
        return url
    }
    
}
