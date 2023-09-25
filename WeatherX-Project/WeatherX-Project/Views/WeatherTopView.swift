//
//  WeatherTopView.swift
//  WeatherX-Project
//
//  Created by 허수빈 on 2023/09/25.
//

import UIKit
import SnapKit

class WeatherTopView: UIView {

    // 배경
    let gradientView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 390, height: 622)
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor,
          UIColor(red: 0.721, green: 0.866, blue: 1, alpha: 1).cgColor
        ]
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 1, c: -1, d: 0.21, tx: 0.5, ty: -0.11))
        layer0.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer0.position = view.center
        view.layer.addSublayer(layer0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        imageView.image = UIImage(named: "darkcloud") // 이미지 이름에 따라 수정
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 위치
    let locateLabel: UILabel = {
        let label = UILabel()
        label.text = "서울특별시 동대문구"
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 1 // 여러 줄이 아닌 한 줄에 표시
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "서울특별시 동대문구", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 온도
    let temperLabel: UILabel = {
        let label = UILabel()
        label.text = "21"
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 110, weight: .light)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.75
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "21", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 온도 기호
    let signView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        let radius = min(view.frame.width, view.frame.height) / 2.0
        view.layer.cornerRadius = radius
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 습도 라벨
    let rainLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.225, green: 0.63, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "RAIN"
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
        label.text = "UV"
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
        label.text = "AQ"
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(gradientView)
        addSubview(talkLabel)
        addSubview(dateLabel)
        addSubview(imageView)
        addSubview(locateLabel)
        addSubview(temperLabel)
        addSubview(signView)
        addSubview(rainLabel)
        addSubview(rain2Label)
        addSubview(uvLabel)
        addSubview(numberLabel)
        addSubview(aqLabel)
        addSubview(number2Label)
        
        // 날씨 안내 멘트
        talkLabel.snp.makeConstraints { make in
            make.width.equalTo(77)
            make.height.equalTo(86)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(94)
        }
        
        // 날짜
        dateLabel.snp.makeConstraints { make in
            make.width.equalTo(114)
            make.height.equalTo(24)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(188)
        }
        
        // 날씨 일러스트
        imageView.snp.makeConstraints { make in
            make.width.equalTo(480)
            make.height.equalTo(360)
            make.leading.equalToSuperview().offset(54)
            make.top.equalToSuperview().offset(51)
        }
        
        // 위치
        locateLabel.snp.makeConstraints { make in
            make.width.equalTo(188)
            make.height.equalTo(24)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(507)
        }
        
        // 온도
        temperLabel.snp.makeConstraints { make in
            make.width.equalTo(115)
            make.height.equalTo(120)
            make.trailing.equalToSuperview().offset(-26)
            make.top.equalToSuperview().offset(494)
        }
        
        // 온도 기호
        signView.snp.makeConstraints { make in
            make.width.equalTo(22)
            make.height.equalTo(22)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(500)
        }
             
        // 습도 제목
        rainLabel.snp.makeConstraints { make in
            make.width.equalTo(54)
            make.height.equalTo(18)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(547)
        }

        // 습도 %
        rain2Label.snp.makeConstraints { make in
            make.width.equalTo(42)
            make.height.equalTo(23)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(567)
        }
        
        // 배경
        gradientView.snp.makeConstraints { make in
            make.width.equalTo(390)
            make.height.equalTo(622)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        // uv 라벨
        uvLabel.snp.makeConstraints { make in
            make.width.equalTo(54)
            make.height.equalTo(18)
            make.leading.equalToSuperview().offset(96)
            make.top.equalToSuperview().offset(547)
        }

        // uv 숫자
        numberLabel.snp.makeConstraints { make in
            make.width.equalTo(10)
            make.height.equalTo(23)
            make.leading.equalToSuperview().offset(103)
            make.top.equalToSuperview().offset(567)
        }
        
        // aq 라벨
        aqLabel.snp.makeConstraints { make in
            make.width.equalTo(54)
            make.height.equalTo(18)
            make.leading.equalToSuperview().offset(168)
            make.top.equalToSuperview().offset(547)
        }
        
        // aq 숫자
        number2Label.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(23)
            make.leading.equalToSuperview().offset(170)
            make.top.equalToSuperview().offset(567)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


