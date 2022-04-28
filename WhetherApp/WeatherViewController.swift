//
//  ViewController.swift
//  WhetherApp
//
//  Created by Abraam on 28.04.2022.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
var weatherManager = WeatherManager()
    private let textFielda: UITextField  = {
        let textField =  UITextField()
        textField.layer.borderWidth = 0.4
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search"
        textField.layer.cornerRadius = 10
        return textField
    }()
    private let weatherimageView: UIImageView  = {
        let image  =  UIImageView()
        image.image = UIImage(systemName: "cloud.sun")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .black
        return image
    }()
    private let degreLabel: UILabel  = {
        let label =  UILabel()
        label.text = "21˚C"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 50, weight: .bold)
        return label
    }()
    private let countryLabel: UILabel  = {
        let label =  UILabel()
        label.text = "London"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    private let searchButton: UIButton  = {
        let button =  UIButton()
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "magnifyingglass.circle"), for: .normal)
        button.addTarget(self, action: #selector(didtapSearch), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(textFielda)
        view.addSubview(degreLabel)
        view.addSubview(countryLabel)
        view.addSubview(weatherimageView)
        view.addSubview(searchButton)
        setConstraints()

   
    
        textFielda.delegate = self

    }
    @objc private func didtapSearch () {
        print(textFielda.text!)
        textFielda.endEditing(true)
       
    }
    

     private func setConstraints() {
         NSLayoutConstraint.activate ([
            textFielda.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            textFielda.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            textFielda.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textFielda.heightAnchor.constraint(equalToConstant: CGFloat(40)),
            
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
            searchButton.trailingAnchor.constraint(equalTo: textFielda.trailingAnchor, constant: 30),
            searchButton.heightAnchor.constraint(equalToConstant: CGFloat(100)),
            searchButton.widthAnchor.constraint(equalToConstant: CGFloat(100)),
            
            weatherimageView.topAnchor.constraint(equalTo: textFielda.bottomAnchor, constant: 30),
            weatherimageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            weatherimageView.heightAnchor.constraint(equalToConstant: CGFloat(60)),
            weatherimageView.widthAnchor.constraint(equalToConstant: CGFloat(60)),
            
            degreLabel.topAnchor.constraint(equalTo: weatherimageView.bottomAnchor, constant: 20),
            degreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            degreLabel.heightAnchor.constraint(equalToConstant: CGFloat(100)),
            degreLabel.widthAnchor.constraint(equalToConstant: CGFloat(120)),
            
            countryLabel.topAnchor.constraint(equalTo: degreLabel.bottomAnchor, constant: 0),
            countryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            countryLabel.heightAnchor.constraint(equalToConstant: CGFloat(100)),
            countryLabel.widthAnchor.constraint(equalToConstant: CGFloat(100)),
          
         ])
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!)
        textField.text = ""
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != " " {
            return true
        } else {
            textField.placeholder = "Search Man"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textFielda.text {
            weatherManager.fetchWeather(cityName: city)
        }
        textField.text = " "
    }


}
// ac6ea6dbc7937e43a88d224a2993f0ef
