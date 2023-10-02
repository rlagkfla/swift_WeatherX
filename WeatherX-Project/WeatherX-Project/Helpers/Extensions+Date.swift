//
//  Extensions+Date.swift
//  WeatherX-Project
//
//  Created by 조규연 on 10/2/23.
//

import Foundation

extension Date {
    func calcuateGMT(time: Int) -> String {
        let timeZone = abs(time) / 3600
        let compare = time < 0 ? "-" : "+"

        if timeZone < 10 {
            return "GMT\(compare)0\(timeZone)"
        } else {
            return "GMT\(compare)\(timeZone)"
        }
    }
    
    func getCountryTime(byTimeZone time: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        formatter.amSymbol = "오전"
        formatter.pmSymbol = "오후"
        formatter.timeZone = TimeZone(abbreviation: calcuateGMT(time: time))
        
        return formatter.string(from: self)
    }
}
