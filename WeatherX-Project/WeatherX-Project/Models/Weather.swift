//
//  Weather.swift
//  WeatherX-Project
//
//  Created by t2023-m0067 on 2023/09/25.
//

import Foundation

// MARK: - 현재 날씨 정보

struct WeatherResponse: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
    let wind: Wind
    let clouds: Clouds
}

struct Main: Decodable {
    let temp: Double // 현재 기온
    let temp_min: Double // 최저 기온
    let temp_max: Double // 최고 기온
    let humidity: Double // 습도
}

struct Weather: Decodable {
    let id: Int // 기상 조건 ID
    let main: String // 날씨 매개변수 그룹(비, 눈, 구름 ​​등)
    let description: String // 그룹 내 날씨 상태
    let icon: String // 날씨 아이콘 ID
}

struct Wind: Decodable {
    let speed: Double // 풍속, m/s
}

struct Clouds: Decodable {
    let all: Int // 흐림, %
}

// MARK: - 1시간 간격 날씨 정보


// MARK: - 5일간 날씨 정보


// MARK: - 날짜 포맷

struct DateFormat {

    static var dateString: String {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "MMM dd hh:mm a"
        
        // 로케일을 영어(미국)로 설정
        myFormatter.locale = Locale(identifier: "en_US")

        // AM/PM 기호를 "AM"과 "PM"으로 설정
        myFormatter.amSymbol = "AM"
        myFormatter.pmSymbol = "PM"

        let date = Date()
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
}
