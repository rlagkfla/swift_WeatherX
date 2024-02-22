//
//  WeatherListViewModel.swift
//  WeatherX-Project
//
//  Created by 김하림 on 2/22/24.
//

import Foundation

class WeatherListViewModel {
    var weatherResponseArray: [WeatherResponse] = [] {
        didSet {
            UserDefaults.standard.setJSON(weatherResponseArray, forKey: "weather")
        }
    }

    var forcastResponseArray: [ForecastResponse] = [] {
        didSet {
            UserDefaults.standard.setJSON(forcastResponseArray, forKey: "forcast")
        }
    }

    var weatherResponse: WeatherResponse?
    var forcastResponse: ForecastResponse?

    var cities: [String] = [] {
        didSet {
            UserDefaults.standard.setJSON(cities, forKey: "city")
        }
    }
}
