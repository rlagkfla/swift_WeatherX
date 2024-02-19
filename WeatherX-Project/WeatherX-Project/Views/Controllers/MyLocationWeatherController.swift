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

    lazy var viewModel = MyLocationWeatherViewModel()
    
    private let locationManager: CLLocationManager = .init() //b

    // 뷰컨 배열 모음 MainWeatherViewController
    lazy var viewArray: [MainWeatherViewController] = []
    
    lazy var bottomView = BottomNavigationView()

    let locationImage: UIImage = .init(systemName: "location.fill")!
    
    lazy var refreshControl = UIRefreshControl().then {
        $0.addTarget(self, action: #selector(refreshWeatherData), for: .valueChanged)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel = MyLocationWeatherViewModel()
        viewArray.append(viewModel.mainWeatherView)
        networkingWeather()
        pageControllerSetup()
        setLayout()
        setupLocationManager()
        pageControlAction()
        buttonTapAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if let data = UserDefaults.standard.getJSON([WeatherResponse].self, forKey: "weather") {
            viewModel.weatherResponseArray = data
        }
        if let data = UserDefaults.standard.getJSON([ForecastResponse].self, forKey: "forcast") {
            viewModel.forcastResponseArray = data
        }
        makeViewArray()
        changePage(to: bottomView.pageControl.currentPage)
        
        if let isAuthorized = UserDefaults.standard.getJSON(Bool.self, forKey: "isAuthorized") {
            viewModel.isAuthorized = isAuthorized
        }
        if viewModel.isAuthorized {
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
        view.addSubview(viewArray[bottomView.pageControl.currentPage].view)
        view.addSubview(bottomView)
        viewModel.mainWeatherView.scrollView.addSubview(refreshControl)
        
        viewArray[bottomView.pageControl.currentPage].view.snp.makeConstraints {
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
 
    }
    
    private func pageControllerSetup() {
        bottomView.pageControl.numberOfPages = viewArray.count
        bottomView.pageControl.currentPage = 0
        bottomView.pageControl.pageIndicatorTintColor = UIColor.lightGray
        bottomView.pageControl.currentPageIndicatorTintColor = UIColor.black
        bottomView.pageControl.setIndicatorImage(locationImage, forPage: 0)
    }
    
    private func pageControlAction(){
        bottomView.pageControl.addTarget(self, action: #selector(changPageView), for: .valueChanged)
    }
    
    @objc func changPageView() {
        changePage(to: bottomView.pageControl.currentPage)
    }
    
    func changePage(to index: Int) {
        guard index >= 0 && index < viewArray.count else {
            return
        }
        let viewControllerToShow = viewArray[index]
        viewArray[bottomView.pageControl.currentPage].view.removeFromSuperview()
        viewArray[bottomView.pageControl.currentPage].removeFromParent()
        addChild(viewControllerToShow)
        view.addSubview(viewControllerToShow.view)
        viewControllerToShow.view.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomView.snp.top)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        // 뷰 컨트롤러 전환 로직 (예: UIPageViewController를 사용하거나, 커스텀 뷰 전환)
        bottomView.pageControl.currentPage = index
    }
    
    private func networkingWeather() { // a
        viewModel.networkingWeather()
    }
    
    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    private func makeViewArray() {
        var dataArray: [MainWeatherViewController] = [viewArray[0]]
        if viewModel.weatherResponseArray.count > 0 {
            for i in 0 ..< (viewModel.weatherResponseArray.count ) {
                let mainVC = MainWeatherViewController()
                mainVC.topView.weatherResponse = viewModel.weatherResponseArray[i]
                mainVC.middleView.forecastResponse = viewModel.forcastResponseArray[i]
                mainVC.bottomView.forecastResponse = viewModel.forcastResponseArray[i]
                dataArray.append(mainVC)
                viewArray = dataArray
            }
            bottomView.pageControl.numberOfPages = viewArray.count
//            pageControl.currentPage = 0
        }
    }
    
    // MARK: - Actions
    
    func buttonTapAction() {
        bottomView.mapViewButtonAction = { [weak self] in
            let mapVC = MapViewController()
            mapVC.viewModel.weatherList = self?.viewModel.weatherResponseArray ?? []
            mapVC.viewModel.weatherResponse = self?.viewModel.weatherResponse
            self?.navigationController?.pushViewController(mapVC, animated: true)
        }
        
        bottomView.menuViewButtonAction = { [weak self] in
            let listVC = WeatherListViewController()
            // 데이터 초기화 코드
    //        UserDefaults.standard.removeObject(forKey: "weather")
    //        UserDefaults.standard.removeObject(forKey: "forcast")
    //        UserDefaults.standard.removeObject(forKey: "city")
            self?.navigationController?.pushViewController(listVC, animated: true)
        }
        
    }

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
            viewModel.isAuthorized = true
        case .denied:
            print("status is denied")
            viewModel.isAuthorized = false
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
            viewModel.networking.lat = location.coordinate.latitude
            viewModel.networking.lon = location.coordinate.longitude
        }
        networkingWeather()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location request failed")
    }
}
