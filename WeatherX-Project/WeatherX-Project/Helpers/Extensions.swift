//
//  Extensions.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

import UIKit

//유저디폴트 익스텐션 매서드 추가
extension UserDefaults {
    func setJSON<T: Encodable>(_ value: T, forKey key: String) {
        do {
            let encoder = JSONEncoder()
            let encodedValue = try encoder.encode(value)
            set(encodedValue, forKey: key)
        } catch {
            print("Error encoding JSON:", error)
        }
    }
    
    func getJSON<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let jsonData = data(forKey: key) else { return nil }
        do {
            let decoder = JSONDecoder()
            let decodedValue = try decoder.decode(type, from: jsonData)
            return decodedValue
        } catch {
            print("Error decoding JSON:", error)
            return nil
        }
    }
}
