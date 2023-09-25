//
//  MapViewController.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

import UIKit
import SnapKit
import MapKit

class MapViewController: UIViewController {
    
    private var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMapView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

private extension MapViewController {
    
    func setupMapView() {
        mapView = MKMapView(frame: view.bounds)
        mapView.delegate = self
        view.addSubview(mapView)
        
        let initialLocation = CLLocationCoordinate2D(latitude: 37.566535, longitude: 126.9779692)
        mapView.setCenter(initialLocation, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = initialLocation
        annotation.title = "서울"
        mapView.addAnnotation(annotation)
    }
    
    func updateUserLocation(latitude: Double, longitude: Double) {
        let userLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = userLocation
        annotation.title = "변경된 도시 이름"
        mapView.addAnnotation(annotation)
        
        mapView.setCenter(userLocation, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "CustomMarker")
        annotationView.glyphText = "24°"
        
        return annotationView
    }
}
