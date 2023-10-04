//
//  WeatherMiddleView.swift
//  WeatherX-Project
//
//  Created by Insu on 9/27/23.
//

import UIKit
import SnapKit
final class WeatherMiddleView: UIView {
    
    var forecastResponse: ForecastResponse?
    
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
        
        collectionView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        collectionView.layer.cornerRadius = 10
        collectionView.isScrollEnabled = true
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        //    layout.sectionInset = .zero
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) // 좌우 여백 조정
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

    func loadImage(icon: String, cell: WeatherCollectionViewCell) {
        let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
        guard  let url = imageUrl else { return }
        DispatchQueue.global().async {
            
            guard let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data)
                
            }
        }
    }

    
}

extension WeatherMiddleView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
        guard let forecastResponse = forecastResponse else { return cell }
        
        let unixDt = forecastResponse.list[indexPath.row].dt
        let dates = Date(timeIntervalSince1970: TimeInterval(unixDt))
        let dateFormatter = DateFormatter()
        
        // 시간 형식 설정
        dateFormatter.dateFormat = "a h시" // "h"는 12 시간 형식, "a"는 AM/PM
        
        // 오전/오후 표시를 위한 로케일 설정 (옵션)
        dateFormatter.locale = Locale(identifier: "ko_KR") // 한국 로케일 설정 (예: 오후)
        
        let formattedDate = dateFormatter.string(from: dates)
        
        cell.timetemper.text = forecastResponse.list[indexPath.row].main.temp.makeRounded() + "º"

        cell.timeLabel.text = formattedDate
        
        loadImage(icon: forecastResponse.list[indexPath.row].weather[0].icon, cell: cell)

        return cell
    }
    // 컬렉션 뷰 사이즈
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 60, height: 110)
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

}
