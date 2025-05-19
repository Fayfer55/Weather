//
//  Location.swift
//  Weather
//
//  Created by Kirill Faifer on 16.05.2025.
//

import Foundation

struct Location: Decodable {
    
    let name: String
    let region: String
    let country: String
    let latitude: Double
    let longitude: Double
    let tzID: String
    let localtimeEpoch: Int
    let localtime: Date

    enum CodingKeys: String, CodingKey {
        case name, region, country, localtime
        case latitude = "lat"
        case longitude = "lon"
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
    }
    
}
