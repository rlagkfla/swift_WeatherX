//
//  MapViewModel.swift
//  WeatherX-Project
//
//  Created by 김하림 on 2/19/24.
//

import Foundation
import MapKit

class MapViewModel {
    
    var networking = Networking.shared
    
    var weatherResponse: WeatherResponse?
    var weatherList: [WeatherResponse] = []
    
    // MVVM 패턴으로 기능 분리 (after)
    // 뷰모델 - func updateUserLocation() + 뷰컨 - private func updateMapView()
    func updateUserLocation() {
        guard let lat = self.weatherResponse?.coord.lat, let lon = self.weatherResponse?.coord.lon else {
            print("WeatherResponse 또는 좌표가 nil입니다.")
            return
        }
        
        let userLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let annotation = MKPointAnnotation()
        annotation.coordinate = userLocation
        annotation.title = self.weatherResponse?.name
        
        weatherList.append(weatherResponse!)
    }
    
// 이전에 뷰컨에 있던 코드 (before)
//    func updateUserLocation() {
//        if let lat = self.weatherResponse?.coord.lat, let lon = self.weatherResponse?.coord.lon {
//            let userLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = userLocation
//            annotation.title = self.weatherResponse?.name
//            mapView.addAnnotation(annotation)
//            
//            mapView.setCenter(userLocation, animated: true)
//        } else {
//            print("coord가 nil입니다.")
//        }
//        
//        guard let weatherResponse else { return }
//        weatherList.append(weatherResponse)
//        
//        for weather in weatherList {
//            let latitude = weather.coord.lat
//            let longitude = weather.coord.lon
//            let userLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = userLocation
//            annotation.title = weather.name
//            mapView.addAnnotation(annotation)
//            
//            mapView.setCenter(userLocation, animated: true)
//        }
//    }
    
}


