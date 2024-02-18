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

final class MyLocationWeatherController: UIViewController {
    
    // MARK: - Properties

    var viewModel: MyLocationWeatherViewModel?
    
//    var networking = Networking.shared // a
    private let locationManager: CLLocationManager = .init() //b
    
//    private var isAuthorized: Bool = false { // a
//        didSet {
//            UserDefaults.standard.setJSON(isAuthorized, forKey: "isAuthorized")
//        }
//    }
    
    // 받아온 데이터를 저장 할 프로퍼티 a
//    var weatherResponse: WeatherResponse?
//    var forecastResponse: ForecastResponse?
//    var weather: Weather?
//    var main: Main?
//    var name: String?
    
//    private var mainWeatherView = MainWeatherViewController()

    // 뷰컨 배열 모음 MainWeatherViewController
    lazy var viewArray: [MainWeatherViewController] = []
    
//    var weatherResponseArray: [WeatherResponse] = [] //a
 
//    var forcastResponseArray: [ForecastResponse] = [] //a

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
    
    let pageControl = UIPageControl()
  
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
    
    lazy var refreshControl = UIRefreshControl().then {
        $0.addTarget(self, action: #selector(refreshWeatherData), for: .valueChanged)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MyLocationWeatherViewModel()
        viewArray.append(viewModel?.mainWeatherView ?? MainWeatherViewController())
        networkingWeather()
        pageControllerSetup()
        setLayout()
        setupLocationManager()
        pageControlAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if let data = UserDefaults.standard.getJSON([WeatherResponse].self, forKey: "weather") {
            viewModel?.weatherResponseArray = data
        }
        if let data = UserDefaults.standard.getJSON([ForecastResponse].self, forKey: "forcast") {
            viewModel?.forcastResponseArray = data
        }
        makeViewArray()
        changePage(to: pageControl.currentPage)
        
        if let isAuthorized = UserDefaults.standard.getJSON(Bool.self, forKey: "isAuthorized") {
            viewModel?.isAuthorized = isAuthorized
        }
        if ((viewModel?.isAuthorized) != nil) {
            locationManager.startUpdatingLocation()
        }
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
        viewModel?.mainWeatherView.scrollView.addSubview(refreshControl)
        
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
    
    func changePage(to index: Int) {
        guard index >= 0 && index < viewArray.count else {
            return
        }
        let viewControllerToShow = viewArray[index]
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
    
    private func networkingWeather() { // a
        
        viewModel?.networkingWeather()
        
        // data fetch
//        networking.getWeather { result in
//            switch result {
//            case .success(let weatherResponse):
//                DispatchQueue.main.async {
//                    self.weatherResponse = weatherResponse
//                    self.weather = weatherResponse.weather.first
//                    self.main = weatherResponse.main
//                    self.name = weatherResponse.name
//                    self.weatherDataBiding(weatherResponse: weatherResponse)
//                }
//            case .failure:
//                print("weatherResponse error")
//            }
//        }
//        
//        networking.getforecastWeather { result in
//            switch result {
//            case .success(let forecastResponse):
//                DispatchQueue.main.async {
//                    self.forecastDataBidning(forecastResponse: forecastResponse)
//                    print(forecastResponse)
//                }
//            case .failure:
//                print("forecastResponse error")
//            }
//        }
    }
    
    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    private func makeViewArray() {
        var dataArray: [MainWeatherViewController] = [viewArray[0]]
        if viewModel?.weatherResponseArray.count ?? 1 > 0 {
            for i in 0 ..< (viewModel?.weatherResponseArray.count ?? 1) {
                let mainVC = MainWeatherViewController()
                mainVC.topView.weatherResponse = viewModel?.weatherResponseArray[i]
                mainVC.middleView.forecastResponse = viewModel?.forcastResponseArray[i]
                mainVC.bottomView.forecastResponse = viewModel?.forcastResponseArray[i]
                dataArray.append(mainVC)
                viewArray = dataArray
            }
            pageControl.numberOfPages = viewArray.count
//            pageControl.currentPage = 0
        }
    }
    
    // MARK: - Actions
    
    @objc func mapViewItemTapped() {
        let mapVC = MapViewController()
        mapVC.weatherList = viewModel?.weatherResponseArray ?? []
        mapVC.weatherResponse = viewModel?.weatherResponse
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @objc func menuViewItemTapped() {
        let listVC = WeatherListViewController()
//        UserDefaults.standard.removeObject(forKey: "weather")
//        UserDefaults.standard.removeObject(forKey: "forcast")
//        UserDefaults.standard.removeObject(forKey: "city")
        navigationController?.pushViewController(listVC, animated: true)
    }
    
    // 데이터 바인딩
//    func weatherDataBiding(weatherResponse: WeatherResponse) { // a
//        let topView = mainWeatherView.topView
//        topView.weatherResponse = weatherResponse
//    }
//    
//    func forecastDataBidning(forecastResponse: ForecastResponse) { // a
//        let middelView = mainWeatherView.middleView
//        middelView.forecastResponse = forecastResponse
//        middelView.collectionView.reloadData()
//        
//        let bottomView = mainWeatherView.bottomView
//        bottomView.forecastResponse = forecastResponse
//        bottomView.tableView.reloadData()
//    }
    
    @objc private func refreshWeatherData(_ sender: Any) { // b
        networkingWeather()
        refreshControl.endRefreshing()
    }
}

// MARK: - CLLocationManagerDelegate

extension MyLocationWeatherController: CLLocationManagerDelegate { // b
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
            viewModel?.isAuthorized = true
        case .denied:
            print("status is denied")
            viewModel?.isAuthorized = false
        case .notDetermined:
            print("status is not determined")
            manager.requestAlwaysAuthorization()
        case .restricted:
            print("status is restricted")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            viewModel?.networking.lat = location.coordinate.latitude
            viewModel?.networking.lon = location.coordinate.longitude
        }
        networkingWeather()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location request failed")
    }
}
