//
//  MapViewController.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

import UIKit
import SnapKit
import MapKit
import Then

class MapViewController: UIViewController {
    
    private var mapView: MKMapView!
//    private var coord: Coord!
//    private var main: Main!
//    private var name: String!
    
    lazy var button = UIButton().then {
        $0.setTitleColor(.green, for: .normal)
        $0.setTitle("change", for: .normal)
        $0.addTarget(self, action: #selector(updateUserLocation), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMapView()
        configure()
        
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
    
    @objc func updateUserLocation() {
//        getWeather()
//        let userLocation = CLLocationCoordinate2D(latitude: self.coord.lat, longitude: self.coord.long)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = userLocation
//        annotation.title = self.name
//        mapView.addAnnotation(annotation)
//        
//        mapView.setCenter(userLocation, animated: true)
    }
    
//    func getWeather(){
//        // data fetch
//        WeatherService().getWeather { result in
//            switch result {
//            case .success(let weatherResponse):
//                DispatchQueue.main.async {
//                    self.coord = weatherResponse.coord
//                    self.main = weatherResponse.main
//                    self.name = weatherResponse.name
//                }
//            case .failure(_ ):
//                print("error")
//            }
//        }
//    }
    
    func configure() {
        mapView.addSubview(self.button)
        
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
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
