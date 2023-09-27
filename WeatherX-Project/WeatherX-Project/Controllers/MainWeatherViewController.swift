//
//  MainWeatherViewController.swift
//  WeatherX-Project
//
//  Created by 천광조 on 2023/09/26.
//

import UIKit
import SnapKit

class MainWeatherViewController: UIViewController {
    private var scrollView = UIScrollView()
    
    let tableView = WeatherBottomView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        snpLayout()
       
    }
    
    
    private func setup() {
        view.addSubview(scrollView)
        scrollView.addSubview(tableView)

//        scrollView.delegate = self
        scrollView.isDirectionalLockEnabled = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .clear
        view.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.9411764706, blue: 1, alpha: 1)
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 20
        
    }
    
    private func snpLayout() {
    
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        //탑뷰
        
        
        //미들뷰
        
        
        //바텀뷰
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(scrollView.frameLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(scrollView.frameLayoutGuide.snp.trailing).offset(-16)
            
            //스크롤뷰 내부 객체에 대해서는 반드시 크기 지정(스크롤 뷰가 가변적 크기이기 때문에)
            $0.height.equalTo(350)
            $0.width.equalTo(365)
        }
        //scrollView의 사이즈는 꼭꼭 반드시 레이아웃을 잡고 프레임 잡을 것
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 1000)
    }

}



//extension MyLocationWeatherController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.x != 0 {
//            scrollView.contentOffset.x = 0
//        }
//    }
//}
