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
    
    private let weatherListTableView = UITableView().then {
        $0.backgroundColor = .white
    }
    
    private let searchController = UISearchController(searchResultsController: nil).then {
        $0.obscuresBackgroundDuringPresentation = false
        $0.searchBar.placeholder = "도시 검색"
    }
    
    private lazy var menu: UIMenu = {
        let editAction = UIAction(title: "목록 편집", image: UIImage(systemName: "pencil"), handler: handleEditAction(_:))
        let tempAction = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "섭씨", image: UIImage(named: "celsius"), handler: handleCelsiusAction(_:)),
            UIAction(title: "화씨", image: UIImage(named: "fahrenheit"), handler: handleFahrenheitAction(_:))
        ])
        let unitAction = UIAction(title: "단위", image: UIImage(systemName: "chart.bar"), handler: handleUnitAction(_:))
        let menu = UIMenu(title: "", children: [editAction, tempAction, unitAction])
        return menu
    }()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        configureNav()
    }

    
    // MARK: - Helper

    private func configureNav() {
        navigationItem.title = "날씨"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.hidesBackButton = true
        
        searchController.searchBar.delegate = self
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
//        weatherListTableView.delegate = self
//        weatherListTableView.dataSource = self
        
        view.addSubview(weatherListTableView)
        weatherListTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    // MARK: - Actions
    
    private func handleEditAction(_ action: UIAction) {
        // 추가된 셀 지우는 기능 추가
    }

    private func handleCelsiusAction(_ action: UIAction) {
        // 추가된 날씨 테이블뷰 셀의 온도가 섭씨 기준으로 바뀌는 로직 구현 예정
    }

    private func handleFahrenheitAction(_ action: UIAction) {
        // 추가된 날씨 테이블뷰 셀의 온도가 화씨 기준으로 바뀌는 로직 구현 예정
    }
    
    private func handleUnitAction(_ action: UIAction) {
        let weatherUnitViewController = WeatherUnitViewController()
        let navController = UINavigationController(rootViewController: weatherUnitViewController)
        self.present(navController, animated: true, completion: nil)
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource



// MARK: - UISearchBarDelegate

extension WeatherListViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let searchViewController = SearchViewController()
        navigationController?.pushViewController(searchViewController, animated: true)
        return false
    }
}






// MARK: - CLLocationManagerDelegate

