//
//  WeatherListCell.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

import UIKit
import Then
import SnapKit

class WeatherListCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let gradientLayer = CAGradientLayer()
    
    let cityLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.textColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1.00)
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        $0.layer.shadowOffset = CGSize(width: 2, height: 1)
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 4
    }
    
    let weatherDescriptionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .gray
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        $0.layer.shadowOffset = CGSize(width: 2, height: 1)
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 4
    }
    
    let temperatureLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        $0.layer.shadowOffset = CGSize(width: 2, height: 1)
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 4
    }
    
    let timeLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        $0.layer.shadowOffset = CGSize(width: 2, height: 1)
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 4
    }
    
    let weatherImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        contentView.addSubviews(cityLabel, weatherDescriptionLabel, temperatureLabel, timeLabel, weatherImageView)
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        cityLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(16)
        }
        
        weatherDescriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.trailing.equalTo(weatherImageView.snp.leading).offset(-8)
            $0.top.equalToSuperview().offset(16)
        }
        
        timeLabel.snp.makeConstraints {
            $0.trailing.equalTo(weatherImageView.snp.leading).offset(-8)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        weatherImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }

        gradientLayer.colors = [
            UIColor(red: 0.859, green: 0.953, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.808, green: 0.91, blue: 1, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = contentView.bounds
        contentView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
