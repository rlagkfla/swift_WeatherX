//
//  WeatherCollectionViewCell.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

import UIKit
import SnapKit
import Then

class WeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cell"
    
    let timetemper: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor(red: 0.179, green: 0.179, blue: 0.179, alpha: 1)
        lb.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.73
        lb.attributedText = NSMutableAttributedString(string: "21º", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        return lb
    }()
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "darkcloud")
        
        return img
    }()
    
    let timeLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        lb.font = UIFont.systemFont(ofSize: 18)
        let timeParagraphStyle = NSMutableParagraphStyle()
        timeParagraphStyle.lineHeightMultiple = 1.14
        lb.attributedText = NSMutableAttributedString(string: "9 AM", attributes: [NSAttributedString.Key.paragraphStyle: timeParagraphStyle])
        
        return lb
    }()

    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [timetemper,imageView,timeLabel])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 10
        sv.alignment = .center
        return sv
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cellLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellLayout(){
        self.addSubview(stackView)

        timetemper.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(3)
        }
        imageView.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.height.equalTo(32)
            $0.leading.equalToSuperview().offset(4)
            $0.top.equalTo(timetemper.snp.bottom).offset(4)
        }
        timeLabel.snp.makeConstraints {
            $0.width.equalTo(44)
            $0.height.equalTo(22)
            $0.centerX.equalTo(imageView)
            $0.top.equalTo(imageView.snp.bottom).offset(12)
        }
        
        stackView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
            $0.edges.equalToSuperview()
        }
    }
   
    
}
