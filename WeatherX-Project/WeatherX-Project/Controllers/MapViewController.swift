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
    
    var weatherResponse: WeatherResponse?
    var networking = Networking.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMapView()
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
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "CustomMarker")
        if let temp = self.weatherResponse?.main.temp {
            annotationView.glyphText = "\(temp)°"
        }
        
        return annotationView
    }
}
