//
//  SearchViewController.swift
//  WeatherX-Project
//
//  Created by Insu on 9/27/23.
//

import UIKit
import Then
import SnapKit

protocol SearchViewControllerDelegate: AnyObject {
    func didAddCity(_ city: String)
}

class SearchViewController: UISearchController, UISearchResultsUpdating {
    
    // MARK: - Properties
    
    weak var searchDelegate: SearchViewControllerDelegate?
    var searchResults: [String] = [] // 도시 이름 저장
    
    var citySearchTableView = UITableView().then {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        searchResultsUpdater = self
        obscuresBackgroundDuringPresentation = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.placeholder = "도시 검색"
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        
        citySearchTableView.delegate = self
        citySearchTableView.dataSource = self
        
        view.addSubview(citySearchTableView)
        citySearchTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // 검색 로직 구현
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = searchResults[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = searchResults[indexPath.row]
        searchDelegate?.didAddCity(selectedCity)
        dismiss(animated: true, completion: nil)
    }
}
