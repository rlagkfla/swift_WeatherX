//
//  MapViewController.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

import UIKit
import MapKit
import Then

class MapViewController: UIViewController {
    
    private var mapView: MKMapView!
    private var coord: Coord?
    private var main: Main?
    private var name: String?
    private var selectedAction: String = "기온" // 기본값
    
    var weatherResponse: WeatherResponse?
    
    private lazy var menu: UIMenu = {
        let tempAction = UIAction(title: "기온", image: UIImage(systemName: "thermometer.medium"), handler: { [weak self] _ in
            self?.handleTemperature()
        })

        let windAction = UIAction(title: "바람", image: UIImage(systemName: "wind"), handler: { [weak self] _ in
            self?.handleWind()
        })

        let menu = UIMenu(title: "", children: [tempAction, windAction])
        return menu
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMapView()
        configureNav()
        updateUserLocation()
        
    }
}

private extension MapViewController {
    
    func setupMapView() {
        mapView = MKMapView(frame: view.bounds)
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    func updateUserLocation() {
        if let latitude = self.weatherResponse?.coord.lat, let longitude = self.weatherResponse?.coord.lon {
            let userLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation
            annotation.title = self.weatherResponse?.name
            mapView.addAnnotation(annotation)
            
            mapView.setCenter(userLocation, animated: true)
        } else {
            print("coord가 nil입니다.")
        }
    }
    
    func configureNav() {
        let doneButton = UIBarButtonItem(title: "완료",
                                         style: .plain,
                                         target: self,
                                         action: #selector(doneButtonTapped))
        doneButton.tintColor = .black
        navigationItem.leftBarButtonItem = doneButton
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "square.3.stack.3d"), style: .plain, target: nil, action: nil)
        rightBarButton.menu = menu
        rightBarButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func doneButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func handleTemperature() {
        selectedAction = "기온"
    }
    
    func handleWind() {
        selectedAction = "바람"
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "CustomMarker")
        
        switch selectedAction {
        case "기온":
            if let temp = self.weatherResponse?.main.temp {
                annotationView.glyphText = "\(temp)°"
            } else {
                print("temp is nil")
            }
        case "바람":
            if let windSpeed = self.weatherResponse?.wind.speed {
                annotationView.glyphText = "\(windSpeed) m/s"
            } else {
                print("windspeed is nil")
            }
        default:
            break
        }
//        if let temp = self.weatherResponse?.main.temp {
//            annotationView.glyphText = "\(temp)°"
//        }
        
        return annotationView
    }
}
