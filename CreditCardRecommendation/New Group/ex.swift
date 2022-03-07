//
//  ex.swift
//  CreditCardRecommendation
//
//  Created by 박형환 on 2022/03/06.
//

import Foundation


extension Encodable {
    
    /// Encode into JSON and return `Data`
    func jsonData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(self)
    }
}

protocol Convertable: Codable {

}

extension Convertable {

    /// implement convert Struct or Class to Dictionary
    func convertToDict() -> Dictionary<String, Any>? {

        var dict: Dictionary<String, Any>? = nil

        do {
            print("init student")
            let encoder = JSONEncoder()

            let data = try encoder.encode(self)
            print("struct convert to data")

            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>

        } catch {
            print(error)
        }

        return dict
    }
}
