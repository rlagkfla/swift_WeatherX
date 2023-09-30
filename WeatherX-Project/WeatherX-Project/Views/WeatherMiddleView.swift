//
//  WeatherMiddleView.swift
//  WeatherX-Project
//
//  Created by Insu on 9/27/23.
//

//
// WeatherMiddleView.swift
// WeatherX-Project
//
// Created by Insu on 9/27/23.
//
import UIKit
import SnapKit
class WeatherMiddleView: UIView {
    // 컬렉션뷰
    lazy var collectionView = UICollectionView()
    let layout = UICollectionViewFlowLayout()
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionViewSetUp()
        setUpLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func collectionViewSetUp(){
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).cgColor
        collectionView.layer.cornerRadius = 10
        collectionView.isScrollEnabled = true
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        //    layout.sectionInset = .zero
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24) // 좌우 여백 조정
        collectionView.collectionViewLayout = layout
    }
    private func setUpLayout(){
        // collectionView의 세로 크기를 설정합니다.
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()

        }
    }
}
extension WeatherMiddleView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
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
    //  func collectionView(
    //   _ collectionView: UICollectionView,
    //   layout collectionViewLayout: UICollectionViewLayout,
    //   minimumInteritemSpacingForSectionAt section: Int
    //   ) -> CGFloat {
    //     return 10
    //   }
    // cell 사이즈( 옆 라인을 고려하여 설정 )
    //  func collectionView(
    //   _ collectionView: UICollectionView,
    //   layout collectionViewLayout: UICollectionViewLayout,
    //   sizeForItemAt indexPath: IndexPath
    //   ) -> CGSize {
    //
    //    return size
    //  }
}
