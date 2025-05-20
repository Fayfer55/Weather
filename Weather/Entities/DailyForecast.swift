//
//  DailyForecast.swift
//  Weather
//
//  Created by Kirill Faifer on 19.05.2025.
//

import Foundation

struct DailyForecast: Decodable {
    
    let date: Date
    let dateEpoch: Int
    let day: Day
    let astro: Astro
    let hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case date, day, astro, hour
        case dateEpoch = "date_epoch"
    }
    
}
