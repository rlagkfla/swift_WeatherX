//
//  WeatherBottomView.swift
//  WeatherX-Project
//
//  Created by 천광조 on 2023/09/26.
//


import UIKit
import SnapKit

class WeatherBottomView: UIView {
    
    let tableView = UITableView()
  
    var forecastResponse: ForecastResponse?
    
    var tableViewTitle = "5일간의 일기예보"
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        tableView.isScrollEnabled = false
        tableViewSetup()
        tableViewLayout()
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "WeatherTableViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tableViewSetup() {
        tableView.dataSource = self
        tableView.delegate = self
        self.addSubview(tableView)
        
    }
    private func tableViewLayout() {
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
    }
    
    func convertDateString(_ inputDateString: String, to outputFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: inputDateString) {
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
    
    func loadImage(icon: String, cell: WeatherTableViewCell) {
        let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
        guard  let url = imageUrl else { return }
        DispatchQueue.global().async {
            
            guard let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                cell.weatherImageView.image = UIImage(data: data)
                
            }
        }
    }
    
}

extension WeatherBottomView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        guard let forecastResponse = forecastResponse else { return cell }
        cell.dateNumberLabel.text = convertDateString(forecastResponse.list[indexPath.row].dtTxt, to: "dd")
        cell.dateTextLabel.text = convertDateString(forecastResponse.list[indexPath.row].dtTxt, to: "EE")
        cell.lowTemperTextLabel.text = formattedString(number: forecastResponse.list[indexPath.row].main.tempMin)
        cell.hightTemperTextLabel.text = formattedString(number: forecastResponse.list[indexPath.row].main.tempMax)
        
        
        loadImage(icon: forecastResponse.list[0].weather[0].icon, cell: cell)
        cell.selectionStyle = .none
        cell.backgroundColor = #colorLiteral(red: 0.9260787368, green: 0.9659976363, blue: 0.9996650815, alpha: 1)
        
        return cell
    }
    
    private func formattedString(number: Double) -> String {
        let formattedString = String(format: "%.1f", number)
        return "\(formattedString)℃"
    }
    
}

extension WeatherBottomView: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 7.0
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewTitle
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
}
