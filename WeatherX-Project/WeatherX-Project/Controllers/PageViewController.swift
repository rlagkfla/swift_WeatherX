//
//  PageViewController.swift
//  WeatherX-Project
//
//  Created by 조규연 on 10/3/23.
//

import UIKit

class PageViewController: UIPageViewController {
    
    private var myLocationWeatherControllers: [MyLocationWeatherController] = [MyLocationWeatherController]()
    var startIndex = 0
    var weatherList: [WeatherResponse] = [WeatherResponse]()

    override func viewDidLoad() {
        super.viewDidLoad()
        createWeatherViewController()
        setupPageView()
        setupFirstPage()

        // Do any additional setup after loading the view.
    }
}

private extension PageViewController {
    func setupPageView() {
        dataSource = self
        delegate = self
    }
    
    func createWeatherViewController() {
        var count = 0
        for i in weatherList {
            guard let eachPage = currentViewController() as? MyLocationWeatherController else {
                return
            }
            eachPage.weatherResponse = i
            eachPage.currentIndex = count
            eachPage.totalPage = weatherList.count
            myLocationWeatherControllers.append(eachPage)
            count += 1
        }
    }
    
    func setupFirstPage() {
        let firstViewController = myLocationWeatherControllers[startIndex]
        setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
    }
    
    func currentViewController() -> UIViewController {
        let currentViewController = MyLocationWeatherController()
        return currentViewController
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let current = viewController as? MyLocationWeatherController,
              let viewControllerIndex = myLocationWeatherControllers.firstIndex(of: current) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0,
              myLocationWeatherControllers.count > previousIndex else {
            return nil
        }
        return myLocationWeatherControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let current = viewController as? MyLocationWeatherController,
              let viewControllerIndex = myLocationWeatherControllers.firstIndex(of: current) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = myLocationWeatherControllers.count
        
        guard orderedViewControllersCount != nextIndex,
              orderedViewControllersCount > nextIndex else {
            return nil
        }
        return myLocationWeatherControllers[nextIndex]
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    
}
