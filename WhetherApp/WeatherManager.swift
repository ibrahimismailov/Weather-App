//
//  WeatherManager.swift
//  WhetherApp
//
//  Created by Abraam on 28.04.2022.
//

import Foundation
protocol WeatherManagerDelegate {
    func didUpdateWeather (_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
class WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?id=2172797&appid=ac6ea6dbc7937e43a88d224a2993f0ef"
    var delegate : WeatherManagerDelegate?
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
        print(urlString)
    }
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJson(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        print(weather.temperatureString)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJson (_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let desc = decodedData.weather[0].description
        
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, description: desc)
             return weather
          
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

