//
//  ViewController.swift
//  Weather
//
//  Created by Kirill Faifer on 15.05.2025.
//

import UIKit
import CoreLocation
import OSLog

final class ViewController: UIViewController {
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "Weather.app", category: "ViewController")
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        Task {
            await checkLocationAuthorization()
        }
    }
    
    // MARK: - Private Helpers
    
    private func checkLocationAuthorization() async {
        let session = CLServiceSession(authorization: .whenInUse)
        
        do {
            for try await diagnostic in session.diagnostics {
                guard !diagnostic.authorizationRequestInProgress else { continue }
                
                if diagnostic.authorizationDenied {
                    logger.debug("denied -> use moscow location")
                } else {
                    logger.debug("allowed -> request location position")
                }
            }
        } catch {
            logger.error("\(error)")
        }
    }

}

