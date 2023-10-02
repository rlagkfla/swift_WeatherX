//
//  WeatherTopView.swift
//  WeatherX-Project
//
//  Created by 허수빈 on 2023/09/25.
//

import UIKit
import SnapKit

class WeatherTopView: UIView {

    var weatherResponse: WeatherResponse? {
        didSet {
            configureUI()
        }
    }
    
    // 날씨 안내 멘트
    let talkLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘은\n날씨가\n추워요"
        label.textColor = UIColor(red: 0.224, green: 0.631, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.83
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "오늘은\n날씨가\n추워요", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 날짜
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Sep 25 08:30 AM"
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.42
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "Sep 25 08:30 AM", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 날씨 일러스트
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "") // 이미지 이름에 따라 수정
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 위치
    let locateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 1 // 여러 줄이 아닌 한 줄에 표시
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        label.textAlignment = .left
        label.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 온도
    let temperLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 60, weight: .thin)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.75
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    // 습도 라벨
    let rainLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.225, green: 0.63, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "강수량"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // 습도 %
    let rain2Label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "58%"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // uv 라벨
    let uvLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.225, green: 0.63, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "풍속"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // uv 숫자
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "4"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // aq 라벨
    let aqLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.225, green: 0.63, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "습도"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // aq 숫자
    let number2Label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "22"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4 // 각 레이블 사이의 간격 조정
        stackView.alignment = .center

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let uvStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4 // 각 레이블 사이의 간격 조정
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        return stackView
    }()
    
    let aqStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4 // 각 레이블 사이의 간격 조정
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func configureUI() {
        guard let weatherResponse = weatherResponse else { return }
        talkLabel.text = "\(weatherResponse.name) 의 날씨는 \(weatherResponse.weather[0].description) 입니다."
        dateLabel.text = DateFormat.dateString
        locateLabel.text = weatherResponse.name
        temperLabel.text = weatherResponse.main.temp.makeRounded() + "º"
        rain2Label.text = String(weatherResponse.rain?.oneHour != nil ? (weatherResponse.rain?.oneHour)! : 0)
        numberLabel.text = String(weatherResponse.wind.speed != nil ? (weatherResponse.wind.speed)! : 0 )
        number2Label.text = String(weatherResponse.main.humidity)
        loadImage()
    }
    
    private func loadImage() {
        guard let weatherResponse = weatherResponse else { return }
        
        let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(weatherResponse.weather[0].icon)@2x.png")
        guard  let url = imageUrl else { return }
        DispatchQueue.global().async {
            
            guard let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
                
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(talkLabel)
        addSubview(dateLabel)
        addSubview(imageView)
        addSubview(locateLabel)
        addSubview(temperLabel)
        addSubview(rainLabel)
        addSubview(rain2Label)
        addSubview(uvLabel)
        addSubview(numberLabel)
        addSubview(aqLabel)
        addSubview(number2Label)
  
        
        // 날씨 안내 멘트
        talkLabel.snp.makeConstraints { make in
            make.width.equalTo(177)
            make.height.equalTo(86)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(54)
        }
        
        // 날짜
        dateLabel.snp.makeConstraints { make in
            make.width.equalTo(114)
            make.height.equalTo(24)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(124)
        }
        
        // 날씨 일러스트
        imageView.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(150)
            make.trailing.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(100)
        }
        
        // 위치
        locateLabel.snp.makeConstraints { make in
            make.width.equalTo(188)
            make.height.equalTo(24)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(250)
        }
        
        // 온도
        temperLabel.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(60)
            make.trailing.equalToSuperview().offset(14)
            make.top.equalToSuperview().offset(286)
            
        }
        
        // 강수량 라벨
        rainLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }

        // 강수량
        rain2Label.snp.makeConstraints { make in
            make.height.equalTo(23)
        }
        
        rainStackView.addArrangedSubview(rainLabel)
        rainStackView.addArrangedSubview(rain2Label)

        self.addSubview(rainStackView)

        rainStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(297)
        }
        
        // 풍속 라벨
        uvLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }

        // 풍속
        numberLabel.snp.makeConstraints { make in
            make.height.equalTo(23)
        }
        
        uvStackView.addArrangedSubview(uvLabel)
        uvStackView.addArrangedSubview(numberLabel)

        self.addSubview(uvStackView)

        uvStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(96)
            make.top.equalToSuperview().offset(297)
        }
        
        // 습도 라벨
        aqLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        
        // 습도
        number2Label.snp.makeConstraints { make in
            make.height.equalTo(23)
        }
        
        aqStackView.addArrangedSubview(aqLabel)
        aqStackView.addArrangedSubview(number2Label)

        self.addSubview(aqStackView)

        aqStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(168)
            make.top.equalToSuperview().offset(297)
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


