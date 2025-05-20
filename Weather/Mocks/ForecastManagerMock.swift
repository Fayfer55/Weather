//
//  ForecastManagerMock.swift
//  Weather
//
//  Created by Kirill Faifer on 20.05.2025.
//

import Foundation
import CoreLocation.CLLocation

actor ForecastManagerMock: ForecastNetworkInterface {
    
    let decodeManager: DecodeManagerInterace
    
    // MARK: - Lifecycle
    
    init(decodeManager: DecodeManagerInterace) {
        self.decodeManager = decodeManager
    }
    
    // MARK: - Helpers
    
    func weather(for coordinate: CLLocationCoordinate2D?) async throws -> Weather {
        try await Task.sleep(for: .seconds(2))
        if Bool.random() {
            throw URLError(.badURL)
        }
        
        guard let url = Bundle.main.url(forResource: "mock_weather_data", withExtension: "txt") else {
            throw URLError(.badURL)
        }
        let data = try Data(contentsOf: url)
        return try decodeManager.decode(data: data)
    }
    
}
