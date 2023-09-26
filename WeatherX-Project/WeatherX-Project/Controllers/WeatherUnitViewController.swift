//
//  WeatherUnitViewController.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

import UIKit
import Then
import SnapKit

class WeatherUnitViewController: UIViewController {
    
    // MARK: - Properties
    
    var selectedRow: Int?
    
    private let weatherUnitTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = UIColor(red: 0.941, green: 0.941, blue: 0.941, alpha: 1)
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
        configureUI()
    }
    
    
    
    
    
    // MARK: - Helper
    
    func configureNav() {
        navigationItem.title = "단위"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .black

        let appearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.backgroundColor = UIColor(red: 0.941, green: 0.941, blue: 0.941, alpha: 1)
            $0.shadowColor = nil
            $0.titleTextAttributes = [.foregroundColor: UIColor.black]
        }
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }

    private func configureUI() {
        weatherUnitTableView.delegate = self
        weatherUnitTableView.dataSource = self
        view.addSubview(weatherUnitTableView)
        weatherUnitTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    
    
    // MARK: - Actions
    
    
    

}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension WeatherUnitViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            if indexPath.row == selectedRow {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }

            if indexPath.row == 0 {
                cell.textLabel?.text = "섭씨 (°C)"
            } else {
                cell.textLabel?.text = "화씨 (℉)"
            }
        } else {
            cell.accessoryType = .none
            // 두 번째 섹션의 셀 구성 코드 나아아아아중에 작성.
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "기온"
        } else {
            return "다른 단위"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            selectedRow = indexPath.row
            tableView.reloadData()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
