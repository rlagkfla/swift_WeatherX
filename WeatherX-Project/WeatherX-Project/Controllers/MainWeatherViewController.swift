//
//  MainWeatherViewController.swift
//  WeatherX-Project
//
//  Created by 천광조 on 2023/09/26.
//

import UIKit
import SnapKit

enum DependingLoaction {
    case myLocation
    case addLocation
}


final class MainWeatherViewController: UIViewController{
   
 
    let topView = WeatherTopView()
    let middleView = WeatherMiddleView()
    let bottomView = WeatherBottomView()

    var dependingLocation: DependingLoaction = .myLocation
    

    private var scrollView = UIScrollView().then {
        $0.isDirectionalLockEnabled = true
        $0.alwaysBounceHorizontal = false
        $0.alwaysBounceVertical = true
        $0.backgroundColor = .clear
    }
    
    let cancelButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("취소", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.frame.size.height = 30
            return button
        }()
    
    let addButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("추가", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.frame.size.height = 30
            return button
        }()
    
    lazy var stackView: UIStackView = {
            let sv = UIStackView(arrangedSubviews: [cancelButton, addButton])
            sv.axis = .horizontal
            sv.distribution  = .fillEqually
            sv.alignment = .fill
            sv.spacing = 250
        sv.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.9411764706, blue: 1, alpha: 1)
            return sv
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        snpLayout()
        cancelButtonTapped()
        addButtonTapped()
    }
    
    private func setup() {
        self.view.addSubview(stackView)
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
        
        if dependingLocation == .addLocation {
            stackView.isHidden = false
            stackView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.trailing.equalToSuperview()
                $0.bottom.equalTo(scrollView.snp.top)
                $0.height.equalTo(50)
            }
            
            
            scrollView.snp.makeConstraints {
    //            $0.top.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.trailing.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.width.equalToSuperview()
            }
        } else {
            stackView.isHidden = true
            scrollView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.trailing.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.width.equalToSuperview()
            }
        }
        
      
        
        topView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.leading.equalTo(scrollView.snp.leading)
            $0.trailing.equalTo(scrollView.snp.trailing)
            $0.height.equalTo(350)
            $0.width.equalTo(365)
        }
        
        middleView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(10)
            $0.leading.equalTo(scrollView.snp.leading).offset(16)
            $0.trailing.equalTo(scrollView.snp.trailing).offset(12)
            $0.height.equalTo(150)
            $0.width.equalTo(365)
        }
        
        bottomView.snp.makeConstraints {
            $0.top.equalTo(middleView.snp.bottom).offset(10)
            $0.leading.equalTo(scrollView.snp.leading).offset(16)
            $0.trailing.equalTo(scrollView.snp.trailing).offset(12)
            $0.bottom.equalTo(scrollView.snp_bottomMargin).offset(-30)
            // 스크롤뷰 내부 객체에 대해서는 반드시 크기 지정(스크롤 뷰가 가변적 크기이기 때문에)
            $0.height.equalTo(350)
            $0.width.equalTo(365)
        }

        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 2000)
    }
    
    private func cancelButtonTapped() {
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
    }
    
    private func addButtonTapped() {
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
    }
    
    
    
    @objc func cancelButtonAction() {
        self.dismiss(animated: true)
    }
    
    var weatherListView: weatherListViewBinding?
    
    @objc func addButtonAction() {
        weatherListView?.weatherListAppend()
        self.dismiss(animated: true)
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
