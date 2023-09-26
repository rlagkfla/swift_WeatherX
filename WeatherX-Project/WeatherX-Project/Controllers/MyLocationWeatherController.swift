//
//  ViewController.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

enum DependingLoaction {
    case myLocation
    case saveLocation
    case addLocation
}


import UIKit
import SnapKit

class MyLocationWeatherController: UIViewController {
    
    // MARK: - Properties
    
    var networking = Networking.shared
    
    // 받아온 데이터를 저장 할 프로퍼티
    var weatherResponse: WeatherResponse?
    var weather: Weather?
    var main: Main?
    var name: String?
    
    private var scrollView = UIScrollView()
        
    let tableView = WeatherBottomView()
    
    private var dependingLocation: DependingLoaction = .myLocation
    
    
    
    lazy var mapViewItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(mapViewItemTapped))
    
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    lazy var menuViewItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(menuViewItemTapped))
    
    let toolbar = UIToolbar()
    
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
               snpLayout()
        networkingWeather()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setup() {
            view.addSubview(toolbar)
            view.addSubview(scrollView)
            scrollView.addSubview(tableView)
            
            toolbar.items = [mapViewItem, flexibleSpace, menuViewItem]
            scrollView.delegate = self
            scrollView.isDirectionalLockEnabled = true
            scrollView.alwaysBounceHorizontal = false
            scrollView.alwaysBounceVertical = true
            scrollView.backgroundColor = .clear
            view.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.9411764706, blue: 1, alpha: 1)
            tableView.clipsToBounds = true
            tableView.layer.cornerRadius = 20

        }
    
    private func snpLayout() {
            
            toolbar.snp.makeConstraints {
                $0.bottom.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.trailing.equalToSuperview()
                $0.height.equalTo(50)
            }
            
            scrollView.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                $0.leading.equalToSuperview()
                $0.trailing.equalToSuperview()
                $0.bottom.equalTo(toolbar.snp.top)
                $0.width.equalToSuperview()
            }
            
            tableView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.equalTo(scrollView.snp.leading).offset(16)
                $0.trailing.equalTo(scrollView.snp.trailing).offset(-16)
                
                //스크롤뷰 내부 객체에 대해서는 반드시 크기 지정(스크롤 뷰가 가변적 크기이기 때문에)
                $0.height.equalTo(350)
                $0.width.equalTo(365)
            }
            //scrollView의 사이즈는 꼭꼭 반드시 레이아웃을 잡고 프레임 잡을 것
            scrollView.contentSize = CGSize(width: view.frame.size.width, height: 1000)
        }
    
    
    private func networkingWeather(){
       
        // data fetch
        networking.getWeather { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self.weatherResponse = weatherResponse
                    self.weather = weatherResponse.weather.first
                    self.main = weatherResponse.main
                    self.name = weatherResponse.name
                }
            case .failure(_ ):
                print("error")
            }
        }
        
    }
    
    
    // MARK: - Helpers
    

    
    
    // MARK: - Actions
    
    @objc func mapViewItemTapped() {
        let mapVC = MapViewController()
        mapVC.weatherResponse = self.weatherResponse
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @objc func menuViewItemTapped() {
        let listVC = ListViewController()
        self.navigationController?.pushViewController(listVC, animated: true)
    }
    
}

extension MyLocationWeatherController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
