//
//  MyLocationWeatherViewModel.swift
//  WeatherX-Project
//
//  Created by 김하림 on 2/18/24.
//

import Foundation

class MyLocationWeatherViewModel {
    
    var networking = Networking.shared
    
    var isAuthorized: Bool = false {
        didSet {
            UserDefaults.standard.setJSON(isAuthorized, forKey: "isAuthorized")
        }
    }
    
    var weatherResponse: WeatherResponse?
    var forecastResponse: ForecastResponse?
    var weather: Weather?
    var main: Main?
    var name: String?
    
    var mainWeatherView = MainWeatherViewController()
    
    var weatherResponseArray: [WeatherResponse] = []
    var forcastResponseArray: [ForecastResponse] = []
    
    // Input
    func networkingWeather() {
        // data fetch
        networking.getWeather { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self.weatherResponse = weatherResponse
                    self.weather = weatherResponse.weather.first
                    self.main = weatherResponse.main
                    self.name = weatherResponse.name
                    self.weatherDataBiding(weatherResponse: weatherResponse)
                }
            case .failure:
                print("weatherResponse error")
            }
        }
        
        networking.getforecastWeather { result in
            switch result {
            case .success(let forecastResponse):
                DispatchQueue.main.async {
                    self.forecastDataBidning(forecastResponse: forecastResponse)
                    print(forecastResponse)
                }
            case .failure:
                print("forecastResponse error")
            }
        }
    }
    
    func weatherDataBiding(weatherResponse: WeatherResponse) { // a
        let topView = mainWeatherView.topView
        topView.weatherResponse = weatherResponse
    }
    
    func forecastDataBidning(forecastResponse: ForecastResponse) { // a
        let middelView = mainWeatherView.middleView
        middelView.forecastResponse = forecastResponse
        middelView.collectionView.reloadData()
        
        let bottomView = mainWeatherView.bottomView
        bottomView.forecastResponse = forecastResponse
        bottomView.tableView.reloadData()
    }
    
}

