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
    private var coord: Coord?
    private var main: Main?
    private var name: String?
    private var selectedAction: String = "기온" // 기본값
    private var rightBarButton: UIBarButtonItem!
    
    var weatherResponse: WeatherResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        configureNav()
        updateUserLocation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        networkingWeather()
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
        
//        let initialLocation = CLLocationCoordinate2D(latitude: 37.566535, longitude: 126.9779692)
//        mapView.setCenter(initialLocation, animated: true)
//        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = initialLocation
//        annotation.title = "서울"
//        mapView.addAnnotation(annotation)
    }
    
    @objc func updateUserLocation() {
        if let latitude = self.coord?.lat, let longitude = self.coord?.lon {
            let userLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation
            annotation.title = self.name
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
        
        rightBarButton = UIBarButtonItem(image: UIImage(systemName: "square.3.stack.3d"), style: .plain, target: nil, action: nil)
        rightBarButton.menu = createMenu()
        rightBarButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func doneButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func createMenu() -> UIMenu {
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
        
        return UIMenu(title: "", children: [tempAction, windAction])
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
    
    func updateAnnotationViews() {
        mapView.removeAnnotations(mapView.annotations)
        updateUserLocation()
        mapView.setNeedsDisplay()
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
        
        return annotationView
    }
}
