//
//  DecodeManager.swift
//  Weather
//
//  Created by Kirill Faifer on 21.05.2025.
//

import Foundation

struct DecodeManager: DecodeManagerInterace {
    
    func decode<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            let formats = ["yyyy-MM-dd HH:mm", "yyyy-MM-dd"]
            
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            
            for format in formats {
                formatter.dateFormat = format
                guard let date = formatter.date(from: dateString) else { continue }
                return date
            }
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Date string does not match any expected format.")
        }
        return try decoder.decode(T.self, from: data)
    }
    
}
