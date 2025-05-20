//
//  LocationManager.swift
//  Weather
//
//  Created by Kirill Faifer on 20.05.2025.
//

import Foundation
import CoreLocation
import OSLog

actor LocationManager: NSObject, LocationInterface {
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "Weather.app", category: "Location Manager")
    
    // MARK: - Location Interface
    
    func authorizationRequest() async {
        try? await checkLocationAuthorization()
    }
    
    func coordinate() async -> CLLocationCoordinate2D? {
        let updates = CLLocationUpdate.liveUpdates()
        do {
            for try await update in updates {
                logger.debug("is coordinates exists – \(update.location?.coordinate != nil)")
                return update.location?.coordinate
            }
            return nil
        } catch {
            return nil
        }
    }
    
    // MARK: - Private Helpers
    
    private func checkLocationAuthorization() async throws {
        let session = CLServiceSession(authorization: .whenInUse)
        
        for try await diagnostic in session.diagnostics {
            guard !diagnostic.authorizationRequestInProgress else { continue }
            logger.debug("location authorization denied – \(diagnostic.authorizationDenied)")
            return
        }
    }
    
}
