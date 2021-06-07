//
//  Codable+Extension.swift
//  Currency
//
//  Created by Rahul Mayani on 31/05/21.
//

import Foundation

extension Encodable {
    var parameters: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

extension Decodable {
    static func decodeJsonData(_ data: Data) -> Self? {
        do {
            return try JSONDecoder().decode(Self.self, from: data)
        } catch let error {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
    
    static func decodeJsonData(_ json: Any) -> Self? {
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            return try JSONDecoder().decode(Self.self, from: data)
        } catch let error {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}
