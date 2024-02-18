//
//  WeatherListViewController.swift
//  WeatherX-Project
//
//  Created by Insu on 2023/09/25.
//

import UIKit
import Then
import SnapKit
import CoreLocation

protocol WeatherListViewBinding: AnyObject {
    func weatherListAppend()
}

final class WeatherListViewController: UIViewController {

    // MARK: - Properties

    private var temperatureUnit = "섭씨"
    private var rightBarButton: UIBarButtonItem!
    private let searchController = SearchViewController(searchResultsController: nil)
    var weatherResponseArray: [WeatherResponse] = [] {
        didSet {
            UserDefaults.standard.setJSON(weatherResponseArray, forKey: "weather")
        }
    }

    var forcastResponseArray: [ForecastResponse] = [] {
        didSet {
            UserDefaults.standard.setJSON(forcastResponseArray, forKey: "forcast")
        }
    }

    var weatherResponse: WeatherResponse?
    var forcastResponse: ForecastResponse?

    var cities: [String] = [] {
        didSet {
            UserDefaults.standard.setJSON(cities, forKey: "city")
        }
    }

    let weatherListTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(WeatherListCell.self, forCellReuseIdentifier: "WeatherListCell")
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        if let data = UserDefaults.standard.getJSON([WeatherResponse].self, forKey: "weather") {
            self.weatherResponseArray = data
        }
        if let data = UserDefaults.standard.getJSON([ForecastResponse].self, forKey: "forcast") {
            self.forcastResponseArray = data
        }
        if let data = UserDefaults.standard.getJSON([String].self, forKey: "city") {
            self.cities = data
        }
    }

    // MARK: - Helpers

    private func configureNav() {
        navigationItem.title = "날씨"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: nil, action: nil)
        rightBarButton.menu = createMenu()
        rightBarButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = rightBarButton

        let appearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.backgroundColor = .white
            $0.largeTitleTextAttributes = [.font: UIFont.systemFont(ofSize: 28, weight: .semibold), .foregroundColor: UIColor.label]
            $0.titleTextAttributes = [.foregroundColor: UIColor.label]
            $0.shadowColor = nil
        }

        let scrollAppearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.backgroundColor = .white
            $0.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
            $0.titleTextAttributes = [.foregroundColor: UIColor.label]
            $0.shadowColor = nil
        }

        // backbutton 임시로 배치
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = scrollAppearance
        navigationController?.navigationBar.compactAppearance = scrollAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func configureUI() {
        searchController.searchDelegate = self
        weatherListTableView.delegate = self
        weatherListTableView.dataSource = self

        view.addSubview(weatherListTableView)
        weatherListTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func createMenu() -> UIMenu {
        let editAction = UIAction(title: "목록 편집", image: UIImage(systemName: "pencil"), handler: handleEditAction(_:))
        let tempAction = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "섭씨", image: UIImage(named: "celsius"), state: temperatureUnit == "섭씨" ? .on : .off, handler: handleCelsiusAction(_:)),
            UIAction(title: "화씨", image: UIImage(named: "fahrenheit"), state: temperatureUnit == "화씨" ? .on : .off, handler: handleFahrenheitAction(_:))
        ])
        let unitAction = UIAction(title: "단위", image: UIImage(systemName: "chart.bar"), handler: handleUnitAction(_:))
        return UIMenu(title: "", children: [editAction, tempAction, unitAction])
    }

    // MARK: - Actions

    private func handleEditAction(_ action: UIAction) {
        if !weatherListTableView.isEditing {
            weatherListTableView.setEditing(true, animated: true)
            let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonTapped(_:)))
            rightBarButton.image = nil
            navigationItem.rightBarButtonItem = doneButton
        }
    }

    @objc private func doneButtonTapped(_ sender: UIBarButtonItem) {
        weatherListTableView.setEditing(false, animated: true)
        rightBarButton.image = UIImage(systemName: "ellipsis.circle")
        rightBarButton.menu = createMenu()
        navigationItem.rightBarButtonItem = rightBarButton
    }

    private func handleCelsiusAction(_ action: UIAction) {
        temperatureUnit = "섭씨"
        rightBarButton.menu = createMenu()
        weatherListTableView.reloadData()
    }

    private func handleFahrenheitAction(_ action: UIAction) {
        temperatureUnit = "화씨"
        rightBarButton.menu = createMenu()
        weatherListTableView.reloadData()
    }

    private func handleUnitAction(_ action: UIAction) {
        let weatherUnitViewController = WeatherUnitViewController()
        let navController = UINavigationController(rootViewController: weatherUnitViewController)
        present(navController, animated: true, completion: nil)
    }

    func setWeatherIcon(weatherIcon: String) -> String {
        var imageName: String

        switch weatherIcon {
        case "01d":
            imageName = "sunny"
        case "02d":
            imageName = "darkcloud"
        case "03d":
            imageName = "darkcloud"
        case "04d":
            imageName = "darkcloud"
        case "09d":
            imageName = "rain"
        case "10d":
            imageName = "sunshower"
        case "11d":
            imageName = "thunder"
        case "13d":
            imageName = "snow"
        case "50d":
            imageName = "wind"
        case "01n":
            imageName = "sunny"
        case "02n":
            imageName = "darkcloud"
        case "03n":
            imageName = "darkcloud"
        case "04n":
            imageName = "darkcloud"
        case "09n":
            imageName = "rain"
        case "10n":
            imageName = "sunshower"
        case "11n":
            imageName = "thunder"
        case "13n":
            imageName = "snow"
        case "50n":
            imageName = "wind"
        default:
            imageName = "unknown"
        }
        return imageName
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension WeatherListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherResponseArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListCell", for: indexPath) as! WeatherListCell
        cell.selectionStyle = .none
        let iconID = weatherResponseArray[indexPath.row].weather[0].icon 
        cell.cityLabel.text = cities[indexPath.row]
        let weatherData = weatherResponseArray[indexPath.row]
        if temperatureUnit == "섭씨" {
            cell.temperatureLabel.text = weatherData.main.temp.makeRounded() + "º"
        } else {
            cell.temperatureLabel.text = weatherData.main.temp.makeFahrenheit() + "º"
        }

        cell.weatherDescriptionLabel.text = weatherData.weather[0].description

        cell.weatherImageView.image = UIImage(named: setWeatherIcon(weatherIcon: iconID))

        cell.timeLabel.text = Date().getCountryTime(byTimeZone: weatherData.timezone)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            weatherResponseArray.remove(at: indexPath.row)
            forcastResponseArray.remove(at: indexPath.row)
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let myVC = navigationController?.viewControllers.first(where: { $0 is MyLocationWeatherController }) as? MyLocationWeatherController {
            myVC.pageControl.currentPage = indexPath.row + 1

            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - SearchViewControllerDelegate

extension WeatherListViewController: SearchViewControllerDelegate {
    func didAddCity(_ city: String, coordinate: CLLocationCoordinate2D) {
        let mainWeatherVC = MainWeatherViewController()
        mainWeatherVC.weatherListView = self
        Networking.shared.lat = coordinate.latitude
        Networking.shared.lon = coordinate.longitude
        Networking.shared.getWeather { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    let topView = mainWeatherVC.topView
                    topView.weatherResponse = weatherResponse
                    topView.city = city
                    mainWeatherVC.dependingLocation = .addLocation
                    self.weatherResponse = weatherResponse
                }
            case .failure(let error):
                print(error)
            }
        }
        Networking.shared.getforecastWeather { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    let middleView = mainWeatherVC.middleView
                    let bottomView = mainWeatherVC.bottomView
                    middleView.forecastResponse = weatherResponse
                    bottomView.forecastResponse = weatherResponse
                    mainWeatherVC.dependingLocation = .addLocation
                    self.forcastResponse = weatherResponse
                    self.present(mainWeatherVC, animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
        cities.append(city)
    }
}

// MARK: - weatherListViewBinding

extension WeatherListViewController: WeatherListViewBinding {
    func weatherListAppend() {
        guard let weatherResponse = weatherResponse else { return }
        guard let forcastResponse = forcastResponse else { return }
        self.weatherResponseArray.append(weatherResponse)
        self.forcastResponseArray.append(forcastResponse)
        weatherListTableView.reloadData()
        self.dismiss(animated: true)
    }
}
