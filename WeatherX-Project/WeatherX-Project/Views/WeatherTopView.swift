//
//  WeatherTopView.swift
//  WeatherX-Project
//
//  Created by 허수빈 on 2023/09/25.
//

import UIKit
import Then
import SnapKit

final class WeatherTopView: UIView {

    var weatherResponse: WeatherResponse? {
        didSet {
            configureUI()
        }
    }
    
    // 날씨 안내 멘트
    let talkLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.224, green: 0.631, blue: 1, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.83
        $0.textAlignment = .center
        $0.attributedText = NSMutableAttributedString(string: "오늘은\n날씨가\n추워요", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 날짜
    let dateLabel = UILabel().then {
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.42
        $0.textAlignment = .center
        $0.attributedText = NSMutableAttributedString(string: "Sep 25 08:30 AM", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 날씨 일러스트
    let imageView = UIImageView().then {
        $0.image = UIImage()
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 태양 날씨 일러스트
    let sunImageView = UIImageView().then {
        $0.image = UIImage()
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 위치
    let locateLabel = UILabel().then {
        $0.text = ""
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        $0.numberOfLines = 1 // 여러 줄이 아닌 한 줄에 표시
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        $0.textAlignment = .left
        $0.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 온도
    let temperLabel = UILabel().then {
        $0.text = ""
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 80, weight: .thin)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.75
        $0.textAlignment = .center
        $0.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
        
    // 습도 라벨
    let rainLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.225, green: 0.63, blue: 1, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.text = "강수량"
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    // 습도 %
    let rain2Label = UILabel().then {
        $0.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .center
        $0.text = "58%"
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // uv 라벨
    let uvLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.225, green: 0.63, blue: 1, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.text = "풍속"
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // uv 숫자
    let numberLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .center
        $0.text = "4"
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // aq 라벨
    let aqLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.225, green: 0.63, blue: 1, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.text = "습도"
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // aq 숫자
    let number2Label = UILabel().then {
        $0.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .center
        $0.text = "22"
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let rainStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let uvStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignment = .center
    }
    
    let aqStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureUI() {
        guard let weatherResponse = weatherResponse else { return }
        talkLabel.text = "\(weatherResponse.name) 의 날씨는 \(weatherResponse.weather[0].description) 입니다."
        dateLabel.text = DateFormat.dateString
        locateLabel.text = weatherResponse.name
        temperLabel.text = weatherResponse.main.temp.makeRounded() + "º"
        rain2Label.text = String(weatherResponse.rain?.oneHour != nil ? (weatherResponse.rain?.oneHour)! : 0) + "mm"
        numberLabel.text = String(weatherResponse.wind.speed != nil ? (weatherResponse.wind.speed)! : 0 ) + "m/s"
        number2Label.text = String(weatherResponse.main.humidity) + "%"
        self.imageView.image = UIImage(named: setWeatherIcon(weatherIcon: weatherResponse.weather[0].icon))
    }
    
    func setWeatherIcon(weatherIcon: String) -> String {
        var imageName: String
        
        switch weatherIcon {
        case "01d":
            imageName = "sunny"
        case "02d":
            imageName = "darkcloud"
        case "03d":
            imageName = "darkcloud"
        case "04d":
            imageName = "darkcloud"
        case "09d":
            imageName = "rain"
        case "10d":
            imageName = "sunshower"
        case "11d":
            imageName = "thunder"
        case "13d":
            imageName = "snow"
        case "50d":
            imageName = "wind"
        case "01n":
            imageName = "sunny"
        case "02n":
            imageName = "darkcloud"
        case "03n":
            imageName = "darkcloud"
        case "04n":
            imageName = "darkcloud"
        case "09n":
            imageName = "rain"
        case "10n":
            imageName = "sunshower"
        case "11n":
            imageName = "thunder"
        case "13n":
            imageName = "snow"
        case "50n":
            imageName = "wind"
        default:
            imageName = "unknown"
        }
        return imageName
    }

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(talkLabel, dateLabel, imageView, sunImageView, locateLabel, temperLabel, rainLabel, rain2Label, uvLabel, numberLabel, aqLabel, number2Label)
  
        // 날씨 안내 멘트
        talkLabel.snp.makeConstraints {
            $0.width.equalTo(177)
            $0.height.equalTo(86)
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(54)
        }
        
        // 날짜
        dateLabel.snp.makeConstraints {
            $0.width.equalTo(114)
            $0.height.equalTo(24)
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(talkLabel.snp.bottom).offset(5)
        }
        
        // 날씨 일러스트
        imageView.contentMode = .scaleAspectFit
        
        imageView.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(250)
            $0.trailing.equalToSuperview().offset(100)
            $0.top.equalToSuperview().offset(20)
        }
        
        // 위치
        locateLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(250)
        }
        
        // 온도
        temperLabel.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(60)
            $0.trailing.equalToSuperview().offset(26)
            $0.top.equalToSuperview().offset(278)
        }
        
        // 강수량 라벨
        rainLabel.snp.makeConstraints {
            $0.height.equalTo(18)
        }

        // 강수량
        rain2Label.snp.makeConstraints {
            $0.height.equalTo(23)
        }
        
        rainStackView.addArrangedSubviews(rainLabel, rain2Label)

        self.addSubview(rainStackView)

        rainStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(297)
        }
        
        // 풍속 라벨
        uvLabel.snp.makeConstraints {
            $0.height.equalTo(18)
        }

        // 풍속
        numberLabel.snp.makeConstraints {
            $0.height.equalTo(23)
        }
        
        uvStackView.addArrangedSubview(uvLabel)
        uvStackView.addArrangedSubview(numberLabel)

        self.addSubview(uvStackView)

        uvStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(96)
            $0.top.equalToSuperview().offset(297)
        }
        
        // 습도 라벨
        aqLabel.snp.makeConstraints {
            $0.height.equalTo(18)
        }
        
        // 습도
        number2Label.snp.makeConstraints {
            $0.height.equalTo(23)
        }
        
        aqStackView.addArrangedSubviews(aqLabel, number2Label)

        self.addSubview(aqStackView)

        aqStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(180)
            $0.top.equalToSuperview().offset(297)
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


