//
//  ForecastManagerMock.swift
//  Weather
//
//  Created by Kirill Faifer on 20.05.2025.
//

import Foundation
import CoreLocation.CLLocation

struct ForecastManagerMock: ForecastNetworkInterface {
    
    func weather(for coordinate: CLLocationCoordinate2D?) async throws -> Weather {
        try await Task.sleep(for: .seconds(2))
        
        guard let url = Bundle.main.url(forResource: "mock_weather_data", withExtension: "txt") else {
            throw URLError(.badURL)
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(formatter)
        return try decoder.decode(Weather.self, from: data)
    }
    
}
