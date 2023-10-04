//
//  WeatherCollectionViewCell.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

import UIKit
import SnapKit
import Then

final class WeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cell"
    
    let timeLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        lb.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        return lb
    }()
    
    let imageView: UIImageView = {
        let img = UIImageView()
        
        return img
    }()
    
    let timetemper: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor(red: 0.179, green: 0.179, blue: 0.179, alpha: 1)
        lb.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
               
        return lb
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [timeLabel,imageView,timetemper])
        sv.axis = .vertical
        sv.distribution = .fill
//        sv.alignment = .fill
        sv.spacing = 5
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

        imageView.snp.makeConstraints {
            $0.height.width.equalTo(48)
        }

        stackView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
   
    
}
