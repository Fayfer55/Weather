//
//  Forecast.swift
//  Weather
//
//  Created by Kirill Faifer on 19.05.2025.
//

import Foundation

struct Forecast: Decodable {
    
    let days: [DailyForecast]
    
    enum CodingKeys: String, CodingKey {
        case days = "forecastday"
    }
    
}
