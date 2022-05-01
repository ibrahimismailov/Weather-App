//
//  ViewController.swift
//  WhetherApp
//
//  Created by Abraam on 28.04.2022.
//

import UIKit
//MARK: - WeatherViewController
class WeatherViewController: UIViewController {
    
    var weatherManager = WeatherManager()
    var weatherdata : WeatherData?
    let searchController = UISearchController()

    private let weatherimageView: UIImageView  = {
        let image  =  UIImageView()
        image.image = UIImage(systemName: "cloud.sun")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        return image
    }()
    private let degreLabel: UILabel  = {
        let label =  UILabel()
        label.text = "21˚C"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    private let countryLabel: UILabel  = {
        let label =  UILabel()
        label.text = "London"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 60, weight: .bold)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        addViews()
        setConstraints()
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        weatherManager.delegate = self
        title = "Weather"    }
    
    private func addViews() {
        view.addSubview(degreLabel)
        view.addSubview(countryLabel)
        view.addSubview(weatherimageView)
    }
     private func setConstraints() {
         NSLayoutConstraint.activate ([
          
            countryLabel.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 40),
            countryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            countryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            countryLabel.heightAnchor.constraint(equalToConstant: CGFloat(80)),
            countryLabel.widthAnchor.constraint(equalToConstant: CGFloat(80)),

            degreLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 20),
            degreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            degreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            degreLabel.heightAnchor.constraint(equalToConstant: CGFloat(80)),
            degreLabel.widthAnchor.constraint(equalToConstant: CGFloat(80)),
            
            weatherimageView.topAnchor.constraint(equalTo: degreLabel.bottomAnchor, constant: 30),
            weatherimageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            weatherimageView.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 40),
            weatherimageView.heightAnchor.constraint(equalToConstant: CGFloat(60)),
            weatherimageView.widthAnchor.constraint(equalToConstant: CGFloat(60))
         ])
    }
}
//MARK: - UITextFieldDelegate
extension WeatherViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard  let text = searchBar.text else {
            return
        }
        let urlString = "https://api.openweathermap.org/data/2.5/weather?&appid=ac6ea6dbc7937e43a88d224a2993f0ef&units=metric\(text)"
        DispatchQueue.main.async {
            self.weatherManager.fetchWeather(cityName: urlString)
        }
     }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
     
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.endEditing(true)
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" {
            return true
        } else {
            searchBar.placeholder =  "Search Countries "
            return false
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let city = searchBar.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchBar.text = ""
    }
}
//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.degreLabel.text =  "\(weather.temperatureString) ˚F"
            self.weatherimageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}


