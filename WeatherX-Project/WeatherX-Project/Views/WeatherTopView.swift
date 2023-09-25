//
//  WeatherTopView.swift
//  WeatherX-Project
//
//  Created by 허수빈 on 2023/09/25.
//


import UIKit
import SnapKit

class WeatherTopView: UIView {

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

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "darkcloud") // 이미지 이름에 따라 수정
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
    
    let boxView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 163, height: 43)
        view.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rainLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.225, green: 0.63, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "RAIN"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    let rain2Label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "58%"
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
        addSubview(boxView)
        addSubview(rainLabel)
        addSubview(rain2Label)


        talkLabel.snp.makeConstraints { make in
            make.width.equalTo(77)
            make.height.equalTo(86)
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(94)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.width.equalTo(114)
            make.height.equalTo(24)
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(188)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(480)
            make.height.equalTo(360)
            make.leading.equalToSuperview().offset(54)
            make.top.equalToSuperview().offset(51)
        }
        
        locateLabel.snp.makeConstraints { make in
            make.width.equalTo(188)
            make.height.equalTo(24)
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(507)
        }
        
        temperLabel.snp.makeConstraints { make in
            make.width.equalTo(115)
            make.height.equalTo(120)
            make.leading.equalToSuperview().offset(235)
            make.top.equalToSuperview().offset(494)
        }
        
        signView.snp.makeConstraints { make in
            make.width.equalTo(22)
            make.height.equalTo(22)
            make.leading.equalToSuperview().offset(344)
            make.top.equalToSuperview().offset(503)
        }
        
        boxView.snp.makeConstraints { make in
            make.width.equalTo(163)
            make.height.equalTo(43)
            make.leading.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(547)
        }
        
        rainLabel.snp.makeConstraints { make in
            make.width.equalTo(54)
            make.height.equalTo(18)
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(547)
        }

        rain2Label.snp.makeConstraints { make in
            make.width.equalTo(42)
            make.height.equalTo(23)
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(567)
        }
        gradientView.snp.makeConstraints { make in
            make.width.equalTo(390)
            make.height.equalTo(622)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

