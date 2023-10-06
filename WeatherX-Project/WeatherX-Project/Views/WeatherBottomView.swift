//
//  WeatherBottomView.swift
//  WeatherX-Project
//
//  Created by 천광조 on 2023/09/26.
//


import UIKit
import SnapKit

final class WeatherBottomView: UIView {
    
    let tableView = UITableView()
    
    var forecastResponse: ForecastResponse? {
        didSet{
            groupDataByDateAndDayOfWeek()
        }
    }
    
    var groupedData: [(date: String, dayOfWeek: String, icon: String, maxTemp: Double, minTemp: Double, rainValue: Double?)] = []
    
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
    private func groupDataByDateAndDayOfWeek() {
        guard let response = forecastResponse else { return }
        
        var groupedData: [(date: String, dayOfWeek: String, icon: String, maxTemp: Double, minTemp: Double, rainValue: Double?)] = []
        var currentDate = ""
        var currentDayOfWeek = ""
        let maxTempOfDay = -100.0
        let minTempOfDay = 100.0
        
        for data in response.list {
            guard let dateText = convertDateString(data.dtTxt, to: "dd") else { return }
            guard let dayOfWeek = convertDateString(data.dtTxt, to: "EE") else { return }
            let rainValue = data.pop
            if dateText != currentDate || dayOfWeek != currentDayOfWeek {
                if let iconName = data.weather.first?.icon {
                    groupedData.append((date: dateText, dayOfWeek: dayOfWeek, icon: iconName, maxTemp: maxTempOfDay, minTemp: minTempOfDay, rainValue: rainValue))
                }
                
                currentDate = dateText
                currentDayOfWeek = dayOfWeek
            } else {
                if data.main.temp > groupedData.last?.maxTemp ?? -100.0 {
                    groupedData[groupedData.count - 1].maxTemp = data.main.temp
                }
                if data.main.temp < groupedData.last?.minTemp ?? 100.0 {
                    groupedData[groupedData.count - 1].minTemp = data.main.temp
                }
            }
            
            
        }
        self.groupedData = groupedData
    }
}

extension WeatherBottomView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        let data = groupedData[indexPath.row]
        
        cell.dateNumberLabel.text = data.date
        cell.dateTextLabel.text = data.dayOfWeek
        loadImage(icon: data.icon, cell: cell)
        cell.lowTemperTextLabel.text = data.minTemp.makeRounded() + "º"
        cell.hightTemperTextLabel.text = data.maxTemp.makeRounded() + "º"
        
        if data.rainValue != 0 {
            cell.percentTextLabel.isHidden = false
            cell.percentTextLabel.text = cell.percentTextLabel.text! + (data.rainValue! * 100).makeRounded() + "%"
        } else {
            cell.percentTextLabel.isHidden = true
        }
        cell.selectionStyle = .none
        cell.backgroundColor = #colorLiteral(red: 0.9260787368, green: 0.9659976363, blue: 0.9996650815, alpha: 0.316571469)
        
        return cell
    }
}

extension WeatherBottomView: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewTitle
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(groupedData[indexPath.row])
    }
}
