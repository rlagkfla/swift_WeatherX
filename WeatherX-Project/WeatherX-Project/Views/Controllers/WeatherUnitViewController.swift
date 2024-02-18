//
//  WeatherUnitViewController.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

import UIKit
import Then
import SnapKit

final class WeatherUnitViewController: UIViewController {
    
    // MARK: - Properties
    
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
    
    private func configureNav() {
        navigationItem.title = "단위"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(completeButtonTapped))
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
    
    @objc private func completeButtonTapped() {
        self.dismiss(animated: true)
    }
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

        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        cell.accessoryType = .none
        cell.textLabel?.text = ""
        
        cell.selectionStyle = .none
        let unitLabel = UILabel()
        let valueLabel = UILabel().then {
            $0.textColor = .lightGray
            $0.font = UIFont.systemFont(ofSize: 14)
        }
        cell.contentView.addSubviews(unitLabel, valueLabel)
        
        unitLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        valueLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                unitLabel.text = "섭씨"
                valueLabel.text = "°C"
            case 1:
                unitLabel.text = "화씨"
                valueLabel.text = "℉"
            default:
                break
            }
        } else {
            switch indexPath.row {
            case 0:
                unitLabel.text = "풍속"
                valueLabel.text = "m/s"
            case 1:
                unitLabel.text = "강수량"
                valueLabel.text = "mm"
            case 2:
                unitLabel.text = "습도"
                valueLabel.text = "%"
            case 3:
                unitLabel.text = "흐림"
                valueLabel.text = "%"
            default:
                break
            }
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
}
