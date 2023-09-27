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
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).cgColor
        cv.layer.cornerRadius = 10
        cv.isScrollEnabled = true
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionViewSetUp()
        
        setUpLayout()

//        let timetemper1 = UILabel()
//        timetemper1.textColor = UIColor(red: 0.179, green: 0.179, blue: 0.179, alpha: 1)
//        timetemper1.font = UIFont.systemFont(ofSize: 26, weight: .bold)
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 0.73
//        timetemper1.attributedText = NSMutableAttributedString(string: "21º", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
//        addSubview(timetemper1)
//        timetemper1.snp.makeConstraints { make in
//            make.width.equalTo(40)
//            make.height.equalTo(44)
//            make.leading.equalToSuperview().offset(56)
//            make.top.equalToSuperview().offset(638)
//        }

//        let imageView = UIImageView(image: UIImage(named: "darkcloud"))
//        addSubview(imageView)
//        imageView.snp.makeConstraints { make in
//            make.width.equalTo(40)
//            make.height.equalTo(32)
//            make.leading.equalToSuperview().offset(50)
//            make.top.equalTo(timetemper1.snp.bottom).offset(4)
//        }

//        let timeLabel = UILabel()
//        timeLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
//        timeLabel.font = UIFont.systemFont(ofSize: 18)
//        let timeParagraphStyle = NSMutableParagraphStyle()
//        timeParagraphStyle.lineHeightMultiple = 1.14
//        timeLabel.attributedText = NSMutableAttributedString(string: "9 AM", attributes: [NSAttributedString.Key.paragraphStyle: timeParagraphStyle])
//        addSubview(timeLabel)
//        timeLabel.snp.makeConstraints { make in
//            make.width.equalTo(44)
//            make.height.equalTo(22)
//            make.centerX.equalTo(imageView)
//            make.top.equalTo(imageView.snp.bottom).offset(12)
//        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func collectionViewSetUp(){
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "WeatherCollectionViewCell")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        
        cell.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        return cell
    }
    
    // 컬렉션 뷰 사이즈
     func collectionView(
          _ collectionView: UICollectionView,
          layout collectionViewLayout: UICollectionViewLayout,
          sizeForItemAt indexPath: IndexPath
     ) -> CGSize {
          return CGSize(width: 50, height: 100)
     }
}

extension WeatherMiddleView: UICollectionViewDelegateFlowLayout {
    
    // 위 아래 간격
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
        ) -> CGFloat {
        return 15
    }

    // 옆 간격
    func collectionView(
      _ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      minimumInteritemSpacingForSectionAt section: Int
      ) -> CGFloat {
          return 10
      }

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
