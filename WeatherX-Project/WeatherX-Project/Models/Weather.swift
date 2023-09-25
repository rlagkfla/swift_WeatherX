//
//  Weather.swift
//  WeatherX-Project
//
//  Created by t2023-m0067 on 2023/09/25.
//

import Foundation

struct WeatherResponse: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
    let wind: Wind
    let clouds: Clouds
//    let date: Date
}

struct Main: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Decodable {
    let speed: Double // 풍속, m/s
}

struct Clouds: Decodable {
    let all: Int // 흐림, %
}

