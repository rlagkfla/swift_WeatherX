//
//  Extensions.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

import UIKit

// MARK: - View

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}

// MARK: - UserDefaults

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
