//
//  Extensions+Double.swift
//  WeatherX-Project
//
//  Created by 조규연 on 2023/09/26.
//

import Foundation

extension Double {
    // kelvin to celsius
    func makeCelsius() -> String {
        let argue = self - 273.15
        return String(format: "%.0f", arguments: [argue])
    }
    
    // kelvin to fahrenheit
    func makeFahrenheit() -> String {
        let argue = (self * 9/5) - 459.67
        return String(format: "%.0f", arguments: [argue])
    }
}
