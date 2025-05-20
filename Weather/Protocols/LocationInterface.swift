//
//  LocationInterface.swift
//  Weather
//
//  Created by Kirill Faifer on 20.05.2025.
//

import Foundation
import CoreLocation.CLLocation

protocol LocationInterface {
    func authorizationRequest() async
    func coordinate() async -> CLLocationCoordinate2D?
}
