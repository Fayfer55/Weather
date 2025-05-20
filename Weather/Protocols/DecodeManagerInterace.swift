//
//  DecodeManagerInterace.swift
//  Weather
//
//  Created by Kirill Faifer on 21.05.2025.
//

import Foundation

protocol DecodeManagerInterace {
    func decode<T: Decodable>(data: Data) throws -> T
}
