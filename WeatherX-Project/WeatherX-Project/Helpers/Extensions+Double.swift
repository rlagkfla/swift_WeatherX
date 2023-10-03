//
//  Extensions+Double.swift
//  WeatherX-Project
//
//  Created by 조규연 on 2023/09/26.
//

import Foundation

extension Double {
    func makeCelsius() -> String {
        let argue = self - 273.15
        return String(format: "%.0f", arguments: [argue])
    }
    
    func makeFahrenheit() -> String {
        let fahrenheit = (self * 9/5) + 32
        return String(format: "%.0f", arguments: [fahrenheit])
    }
    
    func makeRounded() -> String {
        return String(format: "%.0f", self)
    }
}
