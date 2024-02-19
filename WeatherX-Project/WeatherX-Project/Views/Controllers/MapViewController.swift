//
//  MapViewController.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

import UIKit
import MapKit
import Then

final class MapViewController: UIViewController {
    
    lazy var viewModel = MapViewModel()
    
    private var mapView: MKMapView!
    private var selectedAction: String = "기온" // 기본값
    private var rightBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        configureNav()
        updateUserLocation()
        updateMapView()
    }
}

private extension MapViewController {
    
    func setupMapView() {
        mapView = MKMapView(frame: view.bounds)
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    private func updateUserLocation() {
        viewModel.updateUserLocation()
    }
    
    private func updateMapView() {
        for weatherResponse in viewModel.weatherList {
            guard let lat = weatherResponse.coord.lat, let lon = weatherResponse.coord.lon else {
                print("WeatherResponse 또는 좌표가 nil입니다.")
                return
            }
            
            let userLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation
            annotation.title = weatherResponse.name
            mapView.addAnnotation(annotation) // 지도에 어노테이션 추가
            mapView.setCenter(userLocation, animated: true)
        }
    }
    
    private func configureNav() {
        let doneButton = UIBarButtonItem(title: "완료",
                                         style: .plain,
                                         target: self,
                                         action: #selector(doneButtonTapped))
        doneButton.tintColor = .black
        navigationItem.leftBarButtonItem = doneButton
        
        rightBarButton = UIBarButtonItem(image: UIImage(systemName: "square.3.stack.3d"), style: .plain, target: nil, action: nil)
        rightBarButton.menu = createMenu()
        rightBarButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButton
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc func doneButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func createMenu() -> UIMenu {
        let tempAction = UIAction(title: "기온",
                                  image: UIImage(systemName: "thermometer.medium"),
                                  state: selectedAction == "기온" ? .on : .off,
                                  handler: { [weak self] _ in
            self?.handleTemperature()
        })
        
        let windAction = UIAction(title: "바람",
                                  image: UIImage(systemName: "wind"),
                                  state: selectedAction == "바람" ? .on : .off,
                                  handler: { [weak self] _ in
            self?.handleWind()
        })
        
        let precipitation = UIAction(title: "강수량",
                                     image: UIImage(systemName: "umbrella"),
                                     state: selectedAction == "강수량" ? .on : .off,
                                     handler: { [weak self] _ in
            self?.handlePrecipitation()
        })
        
        return UIMenu(title: "", children: [tempAction, windAction, precipitation])
    }
    
    func handleTemperature() {
        selectedAction = "기온"
        rightBarButton.menu = createMenu()
        updateAnnotationViews()
    }
    
    func handleWind() {
        selectedAction = "바람"
        rightBarButton.menu = createMenu()
        updateAnnotationViews()
    }
    
    func handlePrecipitation() {
        selectedAction = "강수량"
        rightBarButton.menu = createMenu()
        updateAnnotationViews()
    }
    
    func updateAnnotationViews() {
        mapView.removeAnnotations(mapView.annotations)
        updateUserLocation()
        updateMapView()
        mapView.setNeedsDisplay()
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "CustomMarker")
        
        guard let annotationTitle = annotation.title, let weather = viewModel.weatherList.first(where: { $0.name == annotationTitle }) else {
            return annotationView
        }
        switch selectedAction {
        case "기온":
            let temp = weather.main.temp
            annotationView.glyphText = "\(temp)°"
        case "바람":
            if let windSpeed = weather.wind.speed {
                annotationView.glyphText = "\(windSpeed) m/s"
            }
        case "강수량":
            if let icon = weather.weather.first?.icon,
               let iconURL = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
                viewModel.networking.downloadImage(fromURL: iconURL) { image in
                    DispatchQueue.main.async {
                        annotationView.glyphImage = image
                    }
                }
                annotationView.glyphImage = UIImage()
            }
        default:
            break
        }
        return annotationView
    }
}


