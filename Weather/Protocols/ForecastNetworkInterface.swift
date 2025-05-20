//
//  ForecastNetworkInterface.swift
//  Weather
//
//  Created by Kirill Faifer on 20.05.2025.
//

import Foundation
import CoreLocation.CLLocation

protocol ForecastNetworkInterface {
    func weather(for coordinate: CLLocationCoordinate2D?) async throws -> Weather
}
