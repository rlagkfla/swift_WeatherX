//
//  Weather.swift
//  WeatherX-Project
//
//  Created by t2023-m0067 on 2023/09/25.
//

import Foundation

// MARK: - 현재 날씨 정보

struct WeatherResponse: Codable {
    let name: String
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let rain: Rain?
    let dt: Int // unix time
}

struct Main: Codable {
    let temp: Double // 현재 기온
    let temp_min: Double // 최저 기온
    let temp_max: Double // 최고 기온
    let humidity: Double // 습도, %
}

struct Weather: Codable {
    let id: Int // 기상 조건 ID
    let main: String // 날씨 매개변수 그룹(비, 눈, 구름 ​​등)
    let description: String // 그룹 내 날씨 상태
    let icon: String // 날씨 아이콘 ID
}

struct Wind: Codable {
    let speed: Double? // 풍속, m/s
}

struct Clouds: Codable {
    let all: Int? // 흐림, %
}

struct Rain: Codable {
    let oneHour: Double? // 1시간 동안의 강우량 mm
    let threeHours: Double? // 3시간 동안의 강우량 mm

    private enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHours = "3h"
    }
}

struct Coord: Codable {
    let lat: Double // 위도
    let lon: Double // 경도
}


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
    
    // api 날짜 데이터(unix time) 변환 메서드 (현재 시간보다 약간 딜레이가 있어서 사용 x)
//    static func dateString(dt: Int) -> String {
//        let date = Date(timeIntervalSince1970: TimeInterval(dt))
//        let myFormatter = DateFormatter()
//        myFormatter.dateFormat = "MMM dd hh:mm a"
//        myFormatter.locale = Locale(identifier: "en_US")
//        myFormatter.amSymbol = "AM"
//        myFormatter.pmSymbol = "PM"
//
//        let savedDateString = myFormatter.string(from: date)
//        return savedDateString
//    }
    
}
