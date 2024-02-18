//
//  BottomNavigationView.swift
//  WeatherX-Project
//
//  Created by 김하림 on 2/18/24.
//

import UIKit
import SnapKit
import Then

final class BottomNavigationView: UIView {

    var mapViewButtonAction: (() -> Void)?
    var menuViewButtonAction: (() -> Void)?
    
    let pageControl = UIPageControl()
    
    lazy var mapViewButton = UIButton(type: .custom).then {
        $0.frame.size.height = 40
        $0.setImage(UIImage(systemName: "map"), for: .normal)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(mapViewItemTapped), for: .touchUpInside)
    }
    
    lazy var menuViewButton = UIButton(type: .custom).then {
        $0.frame.size.height = 40
        $0.tintColor = .black
        $0.setImage(UIImage(systemName: "menucard"), for: .normal)
        $0.addTarget(self, action: #selector(menuViewItemTapped), for: .touchUpInside)
    }
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [mapViewButton, pageControl, menuViewButton])
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 30
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func mapViewItemTapped() {
        mapViewButtonAction?()
    }
    
    @objc private func menuViewItemTapped() {
        menuViewButtonAction?()
    }
    
    private func setUpLayout(){
        addSubview(stackView)
        backgroundColor = .white
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mapViewButton.snp.makeConstraints {
            $0.leading.equalTo(10)
            $0.top.equalTo(self.snp.top).offset(10)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.centerY.equalTo(self)
        }
        
        menuViewButton.snp.makeConstraints {
            $0.trailing.equalTo(-10)
            $0.top.equalTo(self.snp.top).offset(10)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
        }
    }
    
    
}
