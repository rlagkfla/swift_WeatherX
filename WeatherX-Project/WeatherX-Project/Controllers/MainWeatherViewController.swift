//
//  MainWeatherViewController.swift
//  WeatherX-Project
//
//  Created by 천광조 on 2023/09/26.
//

import UIKit
import SnapKit

class MainWeatherViewController: UIViewController {
    
    let topView = WeatherTopView()
    let middleView = WeatherMiddleView()
    let bottomView = WeatherBottomView()
    
    private var scrollView = UIScrollView().then {
        $0.isDirectionalLockEnabled = true
        $0.alwaysBounceHorizontal = false
        $0.alwaysBounceVertical = true
        $0.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        snpLayout()
    }
    
    private func setup() {
        view.addSubview(scrollView)
        scrollView.addSubviews(topView, middleView, bottomView)
        scrollView.delegate = self
        scrollView.isDirectionalLockEnabled = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .clear
        view.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.9411764706, blue: 1, alpha: 1)
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 20
        
    }
    
    
    private func snpLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        topView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.leading.equalTo(scrollView.snp.leading)
            $0.trailing.equalTo(scrollView.snp.trailing)
            $0.height.equalTo(650)
            $0.width.equalTo(365)
        }
        
        middleView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.top).offset(-60)
            $0.leading.equalTo(scrollView.snp.leading)
            $0.trailing.equalTo(scrollView.snp.trailing)
            $0.height.equalTo(450)
            $0.width.equalTo(365)
        }
        
        bottomView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(80)
            $0.leading.equalTo(scrollView.snp.leading).offset(16)
            $0.trailing.equalTo(scrollView.snp.trailing).offset(-16)
            $0.bottom.equalTo(scrollView.snp_bottomMargin).offset(-30)
            // 스크롤뷰 내부 객체에 대해서는 반드시 크기 지정(스크롤 뷰가 가변적 크기이기 때문에)
            $0.height.equalTo(350)
            $0.width.equalTo(365)
        }
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 2000)
    }
}



    // MARK: - UIScrollViewDelegate
extension MainWeatherViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
