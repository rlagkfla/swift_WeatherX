//
//  SearchViewController.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/26.
//

import UIKit
import Then
import SnapKit
import CoreLocation

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var searchBar = UISearchBar().then {
        $0.placeholder = "지역 검색하기"
        $0.backgroundColor = .white
        $0.searchBarStyle = .minimal
    }
    
    private lazy var searchListTableView = UITableView(frame: self.view.frame).then {
        $0.backgroundColor = .white
        $0.rowHeight = 60
    }
    
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNav()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.searchBar.becomeFirstResponder() // 서치바 키보드 작업이 메인 스레드에 잘 실행이 안되어서 비동기 처리
        }
    }
    
    
    // MARK: - Helper
    
    private func configureNav() {
        navigationItem.title = "도시 검색"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.largeTitleDisplayMode = .never
        
        let appearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.titleTextAttributes = [.foregroundColor: UIColor.label]
            $0.shadowColor = nil
        }
        
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func configureUI() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
        }
        
        view.addSubview(searchListTableView)
        searchListTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}








//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {

    
}
