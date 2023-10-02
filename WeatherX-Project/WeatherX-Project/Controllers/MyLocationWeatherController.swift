//
//  ViewController.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

import UIKit
import SnapKit
import Then
import CoreLocation


class MyLocationWeatherController: UIViewController {
    
    // MARK: - Properties
    var networking = Networking.shared
    private let locationManager: CLLocationManager = CLLocationManager()
    
    // 받아온 데이터를 저장 할 프로퍼티
    var weatherResponse: WeatherResponse?
    var weather: Weather?
    var main: Main?
    var name: String?
    //    var city:
    var forecastResponse: ForecastResponse?
    private let mainWeatherView = MainWeatherViewController()
 
    
    // 뷰컨 배열 모음 MainWeatherViewController
    lazy var viewArray: [UIViewController] = [mainWeatherView]
    
    let locationImage: UIImage = .init(systemName: "location.fill")!
    
    
    lazy var bottomView = UIView().then {
        $0.addSubview(stackView)
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var mapViewButton = UIButton(type: .custom).then {
        $0.frame.size.height = 40
        $0.setImage(UIImage(systemName: "map"), for: .normal)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(mapViewItemTapped), for: .touchUpInside)
    }
    
    private let pageControl = UIPageControl()
    
    lazy var menuViewButton = UIButton(type: .custom).then {
        $0.frame.size.height = 40
        $0.tintColor = .black
        $0.setImage(UIImage(systemName: "menucard"), for: .normal)
        $0.addTarget(self, action: #selector(menuViewItemTapped), for: .touchUpInside)
    }
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [mapViewButton, pageControl, menuViewButton])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.spacing = 30
        return sv
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkingWeather()
        pageControllerSetup()
        setLayout()
        setupLocationManager()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Helpers
    
    private func setLayout() {
        view.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.9411764706, blue: 1, alpha: 1)
        guard let mainWeatherView = mainWeatherView.view else { return }
        view.addSubview(mainWeatherView)
        view.addSubview(bottomView)
        
        mainWeatherView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomView.snp.top)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        bottomView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func pageControllerSetup() {
        pageControl.numberOfPages = viewArray.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.setIndicatorImage(locationImage, forPage: 0)
    }
    
    private func networkingWeather() {
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
                    self.loadImage(weatherResponse: weatherResponse)
                    
                }
            case .failure:
                print("weatherResponse error")
            }
        }
        
        networking.getforecastWeather { result in
            switch result {
            case .success(let forecastResponse):
                DispatchQueue.main.async {
                    self.forecastResponse = forecastResponse
                    self.forecastDataBidning(forecastResponse: forecastResponse)
                    print(forecastResponse)
                }
            case .failure:
                print("forecastResponse error")
            }
        }
    }
    
    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
   
   
    // MARK: - Actions
    
    @objc func mapViewItemTapped() {
        let mapVC = MapViewController()
        mapVC.weatherResponse = self.weatherResponse
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @objc func menuViewItemTapped() {
        let listVC = WeatherListViewController()
        navigationController?.pushViewController(listVC, animated: true)
    }
    
 
 
    
    //데이터 바인딩
    func weatherDataBiding(weatherResponse: WeatherResponse) {
        let weatherResponse = weatherResponse
        let main = weatherResponse.main
        let name = weatherResponse.name
        
        let topView = mainWeatherView.topView
        topView.talkLabel.text = "\(weatherResponse.name) 의 날씨는 \(weatherResponse.weather[0].description) 입니다."
        topView.dateLabel.text = DateFormat.dateString
        topView.locateLabel.text = name
        topView.temperLabel.text = main.temp.makeRounded() + "º"
        topView.rain2Label.text = String(weatherResponse.rain?.oneHour != nil ? (weatherResponse.rain?.oneHour)! : 0)
        topView.numberLabel.text = String(weatherResponse.wind.speed != nil ? (weatherResponse.wind.speed)! : 0 )
        topView.number2Label.text = String(main.humidity)
    }
    
    func forecastDataBidning(forecastResponse:ForecastResponse) {
        let middelView = mainWeatherView.middleView
        middelView.forecastResponse = forecastResponse
        middelView.collectionView.reloadData()
        
        
        let bottomView = mainWeatherView.bottomView
        bottomView.forecastResponse = forecastResponse
        bottomView.tableView.reloadData()
    }
    
    func loadImage(weatherResponse: WeatherResponse) {
        let topView = mainWeatherView.topView
        guard let weather = weatherResponse.weather.first else { return }
        let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png")
        guard  let url = imageUrl else { return }
        DispatchQueue.global().async {
            
            guard let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                topView.imageView.image = UIImage(data: data)
                
            }
        }
    }
    
    
}

extension MyLocationWeatherController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied:
            print("status is denied")
            break
        case .notDetermined:
            print("status is not determined")
            manager.requestAlwaysAuthorization()
        case . restricted:
            print("status is restricted")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            networking.lat = location.coordinate.latitude
            networking.lon = location.coordinate.longitude
        }
        networkingWeather()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location request failed")
    }
}
