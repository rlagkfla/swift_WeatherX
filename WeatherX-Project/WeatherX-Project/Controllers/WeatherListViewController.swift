//
//  WeatherListViewController.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

import UIKit
import Then
import SnapKit

class WeatherListViewController: UIViewController {
    
    // MARK: - Properties
    
    var filteredCities = [String]()
    
    private let weatherListTableView = UITableView().then {
        $0.backgroundColor = .white
    }
    
    private let searchController = UISearchController(searchResultsController: nil).then {
        $0.obscuresBackgroundDuringPresentation = false
        $0.searchBar.placeholder = "도시 검색"
    }
    
    private lazy var menu: UIMenu = {
        let editAction = UIAction(title: "목록 편집", image: UIImage(systemName: "pencil"), handler: { _ in
            // 추가된 셀 지우는 기능 추가
        })

        let tempAction = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "섭씨", image: UIImage(systemName: "thermometer.snowflake"), handler: { _ in
                // 추가된 날씨 테이블뷰 셀의 온도가 섭씨 기준으로 바뀌는 로직 구현 예정
            }),
            UIAction(title: "화씨", image: UIImage(systemName: "thermometer.sun"), handler: { _ in
                // 추가된 날씨 테이블뷰 셀의 온도가 화씨 기준으로 바뀌는 로직 구현 예정
            })
        ])

        let unitAction = UIAction(title: "단위", image: UIImage(systemName: "chart.bar"), handler: { _ in
            let weatherUnitViewController = WeatherUnitViewController()
            let navController = UINavigationController(rootViewController: weatherUnitViewController)
            self.present(navController, animated: true, completion: nil)
        })

        let menu = UIMenu(title: "", children: [editAction, tempAction, unitAction])
        return menu
    }()

    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNav()
        configureUI()
    }
    

    
    // MARK: - Helper

    private func configureNav() {
        navigationItem.title = "날씨"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.hidesBackButton = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: nil, action: nil)
        rightBarButton.menu = menu
        rightBarButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = rightBarButton

        let appearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.backgroundColor = .white
            $0.largeTitleTextAttributes = [.font: UIFont.systemFont(ofSize: 28, weight: .semibold), .foregroundColor: UIColor.label]
            $0.titleTextAttributes = [.foregroundColor: UIColor.label]
            $0.shadowColor = nil
        }
        
        let scrollAppearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.backgroundColor = .clear
            $0.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
            $0.titleTextAttributes = [.foregroundColor: UIColor.label]
            $0.shadowColor = nil
        }

        navigationController?.navigationBar.standardAppearance = scrollAppearance
        navigationController?.navigationBar.compactAppearance = scrollAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func configureUI() {
        weatherListTableView.delegate = self
        weatherListTableView.dataSource = self
        //searchController.searchResultsUpdater = self
        
        view.addSubview(weatherListTableView)
        weatherListTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    

    
    
    // MARK: - Actions
    
    
    
    
    

}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension WeatherListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filteredCities[indexPath.row]
        return cell
    }
    
}


// MARK: - UISearchResultsUpdating
