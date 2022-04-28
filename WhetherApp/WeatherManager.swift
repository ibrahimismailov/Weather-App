//
//  WeatherManager.swift
//  WhetherApp
//
//  Created by Abraam on 28.04.2022.
//

import Foundation
struct WeatherManager {
    let url = "https://api.openweathermap.org/data/2.5/weather?&appid=ac6ea6dbc7937e43a88d224a2993f0ef&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(url)&q=\(cityName)"
        self.performReguest(urlString: urlString)
        print(urlString)
    }
    func performReguest(urlString: String ) {
        let url = URL(string: urlString)
        guard let url = url else {
            return
        }
       
        let task = URLSession.shared.dataTask(with: url) { data , response, error in
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                self.parseJson(weatherData: safeData)
               
            }
         
            
        }
        task.resume()
    }
    
    func parseJson(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let response =  try  decoder.decode(WeatherData.self, from: weatherData)
            print(response.name)
        } catch let error {
            print(error.localizedDescription)
        }
    
    }
   
    

    
}
