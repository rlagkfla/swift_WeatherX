//
//  Forecast5days.swift
//  WeatherX-Project
//
//  Created by t2023-m0067 on 2023/09/26.
//

import Foundation

// MARK: - 5일치 3시간 간격 날씨 정보

// 필요한 정보
// 1일치(오늘) 3시간 간격 날씨 정보
// 온도, 강수확률, 시간, 아이콘, 날짜(현재날짜)
// 5일치 날씨 정보
// 날짜(일자/요일), 아이콘, 강수확률, 최저 온도, 최고 온도
// list.dt, list.dt_txt, list.weather.icon, list.pop, list.main.temp_min, list.main.temp_max

struct ForecastResponse: Codable {
    let cod: String
    let city: City
    let list: [Lists]
}

// MARK: - City

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coordi
}

// MARK: - Coord

struct Coordi: Codable {
    let lat, lon: Double // 위도, 경도
}

// MARK: - List

struct Lists: Codable {
    let weather: [Forecast]
    let dt: Int // unix time
    let dtTxt: String // 날짜 텍스트
    let main: MainClass
    let pop: Double // 강수 확률, %
    let rain: Rainy?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, pop, rain
        case dtTxt = "dt_txt"
    }
}

// MARK: - MainClass

struct MainClass: Codable {
    let temp, tempMin, tempMax: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp // 온도, 섭씨
        case tempMin = "temp_min" // 최저 기온
        case tempMax = "temp_max" // 최고 기온
        case humidity // 습도, %
    }
}

// MARK: - Rain

struct Rainy: Codable {
    let the3H: Double // 강수량, mm

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Weather

struct Forecast: Codable {
    let id: Int
//    let main: MainEnum
    let icon: String // 날씨 아이콘 ID
}
