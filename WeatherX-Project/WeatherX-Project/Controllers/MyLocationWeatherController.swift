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
    private var mainWeatherView = MainWeatherViewController()

    // 뷰컨 배열 모음 MainWeatherViewController
    lazy var viewArray: [MainWeatherViewController] = []
    
    var weatherResponseArray: [WeatherResponse] = []
 
    var forcastResponseArray: [ForecastResponse] = [] 

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
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 30
        return sv
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewArray.append(mainWeatherView)
        networkingWeather()
        pageControllerSetup()
        setLayout()
        setupLocationManager()
        pageControlAction()
        if let data = UserDefaults.standard.getJSON([WeatherResponse].self, forKey: "weather") {
            self.weatherResponseArray = data
        }
       if let data = UserDefaults.standard.getJSON([ForecastResponse].self, forKey: "forcast") {
            self.forcastResponseArray = data
        }
        makeViewArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        print(viewArray.count)
        print(viewArray)
        print(weatherResponseArray.count)
        print(weatherResponseArray)
       
        print(viewArray.count)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Helpers
    
    private func setLayout() {
        view.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.9411764706, blue: 1, alpha: 1)
        view.addSubview(viewArray[pageControl.currentPage].view)
        view.addSubview(bottomView)
        
        viewArray[pageControl.currentPage].view.snp.makeConstraints {
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
        mapViewButton.snp.makeConstraints {
            $0.leading.equalTo(10)
            $0.top.equalTo(bottomView.snp.top).offset(10)
            $0.bottom.equalTo(bottomView.snp.bottom).offset(-10)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.centerY.equalTo(bottomView)
        }
        
        menuViewButton.snp.makeConstraints {
            $0.trailing.equalTo(-10)
            $0.top.equalTo(bottomView.snp.top).offset(10)
            $0.bottom.equalTo(bottomView.snp.bottom).offset(-10)
        }
    }
    
    private func pageControllerSetup() {
        pageControl.numberOfPages = viewArray.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.setIndicatorImage(locationImage, forPage: 0)
    }
    
    private func pageControlAction(){
        self.pageControl.addTarget(self, action: #selector(changPageView), for: .valueChanged)
    }
    
    @objc func changPageView() {
        changePage(to: pageControl.currentPage)
    }
    
    private func changePage(to index: Int) {
        guard index >= 0 && index < viewArray.count else {
            return
        }
        let viewControllerToShow = viewArray[index]
        print(viewControllerToShow.topView.talkLabel)
        viewArray[pageControl.currentPage].view.removeFromSuperview()
        viewArray[pageControl.currentPage].removeFromParent()
        addChild(viewControllerToShow)
        view.addSubview(viewControllerToShow.view)
        viewControllerToShow.view.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomView.snp.top)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        // 뷰 컨트롤러 전환 로직 (예: UIPageViewController를 사용하거나, 커스텀 뷰 전환)
        pageControl.currentPage = index
    }
    
    private func networkingWeather() {
        // data fetch
        networking.getWeather { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
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
    
    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    private func makeViewArray() {
        if weatherResponseArray.count > 0 {
            for i in 0..<weatherResponseArray.count {
                let mainVC = MainWeatherViewController()
                mainVC.topView.weatherResponse = weatherResponseArray[i]
                mainVC.middleView.forecastResponse = forcastResponseArray[i]
                mainVC.bottomView.forecastResponse = forcastResponseArray[i]
                self.viewArray.append(mainVC)
            }
            pageControl.numberOfPages = viewArray.count
            pageControl.currentPage = 0
        }
      
    }
    
   
   
    // MARK: - Actions
    
    @objc func mapViewItemTapped() {
        let mapVC = MapViewController()
        mapVC.weatherResponse = self.weatherResponse
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @objc func menuViewItemTapped() {
        let listVC = WeatherListViewController()
//        UserDefaults.standard.removeObject(forKey: "weather")
//        UserDefaults.standard.removeObject(forKey: "forcast")
//        UserDefaults.standard.removeObject(forKey: "city")
        navigationController?.pushViewController(listVC, animated: true)
    }
    
 
 
    
    //데이터 바인딩
    func weatherDataBiding(weatherResponse: WeatherResponse) {
        let topView = mainWeatherView.topView
        topView.weatherResponse = weatherResponse
    }
    
    func forecastDataBidning(forecastResponse:ForecastResponse) {
        let middelView = mainWeatherView.middleView
        middelView.forecastResponse = forecastResponse
        middelView.collectionView.reloadData()
        
        
        let bottomView = mainWeatherView.bottomView
        bottomView.forecastResponse = forecastResponse
        bottomView.tableView.reloadData()
    }

    func setWeatherIcon(weatherIcon: String) {
        var imageName: String

        let topView = mainWeatherView.topView
        
        switch weatherIcon {
        case "01d":
            imageName = "sunny"
        case "02d":
            imageName = "darkcloud"
        case "03d":
            imageName = "darkcloud"
        case "04d":
            imageName = "darkcloud"
        case "09d":
            imageName = "rain"
        case "10d":
            imageName = "sunshower"
        case "11d":
            imageName = "thunder"
        case "13d":
            imageName = "snow"
        case "50d":
            imageName = "wind"
        case "01n":
            imageName = "sunny"
        case "02n":
            imageName = "darkcloud"
        case "03n":
            imageName = "darkcloud"
        case "04n":
            imageName = "darkcloud"
        case "09n":
            imageName = "rain"
        case "10n":
            imageName = "sunshower"
        case "11n":
            imageName = "thunder"
        case "13n":
            imageName = "snow"
        case "50n":
            imageName = "wind"
        default:
            imageName = "unknown"
        }
        print("Setting icon with value: \(weatherIcon)")
        if let image = UIImage(named: imageName) {
            topView.imageView.image = image
        } else {
            topView.imageView.image = UIImage(named: "default")
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


