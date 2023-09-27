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
    
    let cityLabel = UILabel().then {
        $0.text = "서울"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    let weatherDescriptionLabel = UILabel().then {
        $0.text = "날씨가 추워요"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .gray
    }
    
    let temperatureLabel = UILabel().then {
        $0.text = "20°"
        $0.font = UIFont.systemFont(ofSize: 22, weight: .medium)
    }
    
    let timeLabel = UILabel().then {
        $0.text = "12:00 PM"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .gray
    }
    
    let weatherImageView = UIImageView().then {
        $0.image = UIImage(named: "darkcloud")
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
    
    // MARK: - Helpers
    
    private func configureUI() {
        contentView.addSubviews(cityLabel, weatherDescriptionLabel, temperatureLabel, timeLabel, weatherImageView)
        
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
    }
}
