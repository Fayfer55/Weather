//
//  Day.swift
//  Weather
//
//  Created by Kirill Faifer on 19.05.2025.
//

import Foundation

struct Day: Decodable {
    
    let maxTempC: Double
    let maxTempF: Double
    let minTempC: Double
    let minTempF: Double
    let avgTempC: Double
    let avgTempF: Double
    let maxWindMph: Double
    let maxWindKph: Double
    let totalPrecipMm: Double
    let totalPrecipIn: Double
    let totalSnowCm: Double
    let avgVisKm: Double
    let avgVisMiles: Double
    let avgHumidity: Int
    let dailyWillItRain: Int
    let dailyChanceOfRain: Int
    let dailyWillItSnow: Int
    let dailyChanceOfSnow: Int
    let condition: Condition
    let uv: Double

    enum CodingKeys: String, CodingKey {
        case condition, uv
        case maxTempC = "maxtemp_c"
        case maxTempF = "maxtemp_f"
        case minTempC = "mintemp_c"
        case minTempF = "mintemp_f"
        case avgTempC = "avgtemp_c"
        case avgTempF = "avgtemp_f"
        case maxWindMph = "maxwind_mph"
        case maxWindKph = "maxwind_kph"
        case totalPrecipMm = "totalprecip_mm"
        case totalPrecipIn = "totalprecip_in"
        case totalSnowCm = "totalsnow_cm"
        case avgVisKm = "avgvis_km"
        case avgVisMiles = "avgvis_miles"
        case avgHumidity = "avghumidity"
        case dailyWillItRain = "daily_will_it_rain"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceOfSnow = "daily_chance_of_snow"
    }
    
}
