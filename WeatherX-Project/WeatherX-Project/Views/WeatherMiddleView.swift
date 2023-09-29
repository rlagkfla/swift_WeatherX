//
//  WeatherMiddleView.swift
//  WeatherX-Project
//
//  Created by Insu on 9/27/23.
//

import UIKit
import SnapKit

class WeatherMiddleView: UIView {
    
    // 배경 uiview
//    let backgroundView = UIView().then {
//        $0.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).cgColor
//        $0.layer.cornerRadius = 10
//    }
    
    // 컬렉션뷰
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).cgColor
        cv.layer.cornerRadius = 10
//        cv.isScrollEnabled = true
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionViewSetUp()
        
        setUpLayout()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func collectionViewSetUp(){
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
        // 컬렉션 뷰의 기능을 누가 사용하지는지 ? 👉 self 즉, 나 자신 클래스인 MainViewController
        collectionView.delegate = self
        //  컬렉션 뷰의 데이타 제공자는 ? 👉  self 즉, 나 자신 클래스인 MainViewController
        collectionView.dataSource = self
        self.addSubview(collectionView)
    }
    
    private func setUpLayout(){
        
        collectionView.snp.makeConstraints {
//            $0.width.equalTo(342)
            $0.height.equalTo(147)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.top.equalToSuperview().offset(624)
        }
        
        
        
    }
}

extension WeatherMiddleView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
        
//        cell.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        return cell
    }
    
    // 컬렉션 뷰 사이즈
     func collectionView(
          _ collectionView: UICollectionView,
          layout collectionViewLayout: UICollectionViewLayout,
          sizeForItemAt indexPath: IndexPath
     ) -> CGSize {
          return CGSize(width: 60, height: 100)
     }
}

extension WeatherMiddleView: UICollectionViewDelegateFlowLayout {
    
    // 위 아래 간격
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
        ) -> CGFloat {
        return 10
    }

    // 옆 간격
//    func collectionView(
//      _ collectionView: UICollectionView,
//      layout collectionViewLayout: UICollectionViewLayout,
//      minimumInteritemSpacingForSectionAt section: Int
//      ) -> CGFloat {
//          return 10
//      }

    // cell 사이즈( 옆 라인을 고려하여 설정 )
//    func collectionView(
//      _ collectionView: UICollectionView,
//      layout collectionViewLayout: UICollectionViewLayout,
//      sizeForItemAt indexPath: IndexPath
//      ) -> CGSize {
//
//        return size
//    }
}
