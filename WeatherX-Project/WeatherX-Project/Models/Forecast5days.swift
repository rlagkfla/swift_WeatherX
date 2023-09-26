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
// 온도, 강수확률, 시간, 아이콘, 날짜(현재날짜)?
// 5일치 날씨 정보
// 날짜(일자/요일), 아이콘, 강수확률, 최저 온도, 최고 온도
// list.dt, list.dt_txt, list.weather.icon, list.pop, list.main.temp_min, list.main.temp_max

struct ForecastResponse: Decodable {
    let city: City
    let list: [List]
}

struct City: Decodable {
    let name: String
    let coord: Coordi
}

struct List: Decodable {
    let dt: Int // unix time
    let dt_txt: String? // 날짜 텍스트
    let pop: Double? // 강수 확률, %
    let weather: Icon
    let main: Temp
}

struct Icon: Decodable {
    let icon: String // 날씨 아이콘 ID
}

struct Temp: Decodable {
    let temp_min: Double // 최저 기온
    let temp_max: Double // 최고 기온
}

struct Coordi: Decodable {
    let lat: Double // 위도
    let lon: Double // 경도
}
