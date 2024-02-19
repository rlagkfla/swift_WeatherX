//
//  Networking.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

import Foundation
import CoreLocation
import UIKit

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
    
    private init() {}
    
    // 현재 날씨 api
    func getWeather(completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        
        // API 호출을 위한 URL
        let url = URL(string: "\(API.weatherApiUrl)?lat=\(lat)&lon=\(lon)&\(API.key)&\(API.unit)&\(API.lang)")
        guard let url = url else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            // Data 타입으로 받은 리턴을 디코드
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)

            // 성공
            if let weatherResponse = weatherResponse {
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
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            // Data 타입으로 받은 리턴을 디코드
            let forecastResponse = try? JSONDecoder().decode(ForecastResponse.self, from: data)

            // 성공
            if let forecastResponse = forecastResponse {
                completion(.success(forecastResponse)) // 성공한 데이터 저장
            } else {
                completion(.failure(.decodingError))
            }
        }.resume() // 이 dataTask 시작
    }
    
    // 이미지 다운로드
    func downloadImage(fromURL url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
