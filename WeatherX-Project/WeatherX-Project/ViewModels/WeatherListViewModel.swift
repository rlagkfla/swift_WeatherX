//
//  WeatherListViewModel.swift
//  WeatherX-Project
//
//  Created by 김하림 on 2/22/24.
//

import Foundation
import CoreLocation

class WeatherListViewModel {
    
    var networking = Networking.shared
    
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

//extension WeatherListViewModel: SearchViewControllerDelegate {
//    
//    func didAddCity(_ city: String, coordinate: CLLocationCoordinate2D) {
//        let mainWeatherVC = MainWeatherViewController()
//        mainWeatherVC.weatherListView = self
//        Networking.shared.lat = coordinate.latitude
//        Networking.shared.lon = coordinate.longitude
//        Networking.shared.getWeather { result in
//            switch result {
//            case .success(let weatherResponse):
//                DispatchQueue.main.async {
//                    let topView = mainWeatherVC.topView
//                    topView.weatherResponse = weatherResponse
//                    topView.city = city
//                    mainWeatherVC.dependingLocation = .addLocation
//                    self.weatherResponse = weatherResponse
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//        Networking.shared.getforecastWeather { result in
//            switch result {
//            case .success(let weatherResponse):
//                DispatchQueue.main.async {
//                    let middleView = mainWeatherVC.middleView
//                    let bottomView = mainWeatherVC.bottomView
//                    middleView.forecastResponse = weatherResponse
//                    bottomView.forecastResponse = weatherResponse
//                    mainWeatherVC.dependingLocation = .addLocation
//                    self.forcastResponse = weatherResponse
//                    self.present(mainWeatherVC, animated: true)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//        cities.append(city)
//    }
//    
//}
