//
//  ClassIdentifiable.swift
//  Weather
//
//  Created by Kirill Faifer on 20.05.2025.
//

import Foundation

protocol ClassIdentifiable {
    static var reuseId: String { get }
}

extension ClassIdentifiable {
    
    static var reuseId: String {
        return String(describing: self)
    }
    
}
