//
//  Networking.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

import Foundation
import CoreLocation

// 에러 정의
enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}

final class Networking {
    
    // singleton
    static let shared = Networking()
    var lat: Double = 37.5683
    var lon: Double = 126.9778
    
    private init(){}
    
    // 현재 날씨 api
    func getWeather(completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        
        // API 호출을 위한 URL
//        let url = URL(string: "\(API.weatherApiUrl)?\(API.location)&\(API.key)&\(API.unit)&\(API.lang)")
        let url = URL(string: "\(API.weatherApiUrl)?lat=\(lat)&lon=\(lon)&\(API.key)&\(API.unit)&\(API.lang)")
        guard let url = url else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            // Data 타입으로 받은 리턴을 디코드
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)

            // 성공
            if let weatherResponse = weatherResponse {
//                print("weather : \(weatherResponse)")
//                print("date: \(DateFormat.dateString(dt: weatherResponse.dt))") 
                completion(.success(weatherResponse)) // 성공한 데이터 저장
            } else {
                completion(.failure(.decodingError))
            }
        }.resume() // 이 dataTask 시작
    }
    
    // 5일치 날씨 api
    func getforecastWeather(completion: @escaping (Result<ForecastResponse, NetworkError>) -> Void) {
        
        // API 호출을 위한 URL
        let url = URL(string: "\(API.forecastApiUrl)?lat=\(lat)&lon=\(lon)&\(API.key)&\(API.unit)&\(API.lang)")
        guard let url = url else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            // Data 타입으로 받은 리턴을 디코드
            let forecastResponse = try? JSONDecoder().decode(ForecastResponse.self, from: data)

            // 성공
            if let forecastResponse = forecastResponse {
//                print("forecast : \(forecastResponse)")
                completion(.success(forecastResponse)) // 성공한 데이터 저장
            } else {
                completion(.failure(.decodingError))
            }
        }.resume() // 이 dataTask 시작
    }
}

extension Networking: LocationSelectionDelegate {
    func didSelectLocation(_ coordinate: CLLocationCoordinate2D) {
        lat = coordinate.latitude
        lon = coordinate.longitude
    }
}
