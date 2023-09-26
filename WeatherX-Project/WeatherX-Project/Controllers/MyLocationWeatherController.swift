//
//  ViewController.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

import UIKit
import SnapKit

class MyLocationWeatherController: UIViewController {
    
    // MARK: - Properties
    
    var networking = Networking.shared
    
    // 받아온 데이터를 저장 할 프로퍼티
    var weather: Weather?
    var main: Main?
    var name: String?
    
    lazy var mapViewItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(mapViewItemTapped))
    
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    lazy var menuViewItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(menuViewItemTapped))
    
    let toolbar: UIToolbar = {
        let tv = UIToolbar()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(toolbar)
        view.backgroundColor = .white
        toolbar.items = [mapViewItem, flexibleSpace, menuViewItem]
        toolbarLayout()
        
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

    private func networkingWeather(){
       
        // data fetch
        networking.getWeather { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
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
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @objc func menuViewItemTapped() {
        let listVC = ListViewController()
        self.navigationController?.pushViewController(listVC, animated: true)
    }
 
    func toolbarLayout() {
        NSLayoutConstraint.activate([
            toolbar.heightAnchor.constraint(equalToConstant: 80),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])}
    
}

