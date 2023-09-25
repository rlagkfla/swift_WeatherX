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
    let toolbar: UIToolbar = {
        let tv = UIToolbar()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let mapViewItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(mapViewItemTapped))
    
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    let menuViewItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(menuViewItemTapped))
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemIndigo
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
    
}

