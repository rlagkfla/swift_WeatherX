//
//  WeatherMiddleView.swift
//  WeatherX-Project
//
//  Created by Insu on 9/27/23.
//

import UIKit
import SnapKit

class WeatherMiddleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let backgroundView = UIView()
        backgroundView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).cgColor
        backgroundView.layer.cornerRadius = 10
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.width.equalTo(342)
            make.height.equalTo(147)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(624)
        }

        let timetemper1 = UILabel()
        timetemper1.textColor = UIColor(red: 0.179, green: 0.179, blue: 0.179, alpha: 1)
        timetemper1.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.73
        timetemper1.attributedText = NSMutableAttributedString(string: "21º", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        addSubview(timetemper1)
        timetemper1.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(44)
            make.leading.equalToSuperview().offset(56)
            make.top.equalToSuperview().offset(638)
        }

        let imageView = UIImageView(image: UIImage(named: "darkcloud"))
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(32)
            make.leading.equalToSuperview().offset(50)
            make.top.equalTo(timetemper1.snp.bottom).offset(4)
        }

        let timeLabel = UILabel()
        timeLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        timeLabel.font = UIFont.systemFont(ofSize: 18)
        let timeParagraphStyle = NSMutableParagraphStyle()
        timeParagraphStyle.lineHeightMultiple = 1.14
        timeLabel.attributedText = NSMutableAttributedString(string: "9 AM", attributes: [NSAttributedString.Key.paragraphStyle: timeParagraphStyle])
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.width.equalTo(44)
            make.height.equalTo(22)
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(12)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
