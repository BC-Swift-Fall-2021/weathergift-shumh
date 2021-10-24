//
//  WeatherDetail.swift
//  WeatherGift
//
//  Created by Richard Shum on 10/11/21.
//

import Foundation

class WeatherDetail: WeatherLocation {
    
    struct Result: Codable {
        var timezone: String
        var current: Current
    }
    struct Current: Codable {
        var dt: TimeInterval
        var temp: Double
        var weather: [Weather]
    }
    struct Weather: Codable {
        var description: String
        var icon: String
    }
    
    var timezone = ""
    var currentTime = 0.0
    var temperature = 0
    var summary = ""
    var dailyIcon = ""
    
    func getData(completed: @escaping () -> ()) {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&appid=\(APIkeys.openWeatherKey)"
        
        print("We are access the URL \(urlString)")
        
        // Create a URL
        guard let url = URL(string: urlString) else {
            print("Error: Could not create an URL from \(urlString)")
            completed()
            return
        }
        
        // Create Session
        let session = URLSession.shared
        
        // Get Data from .dataTask method
        let task = session.dataTask(with: url) { data, reponse, error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            
            // deal with the data
            do {
                let result = try JSONDecoder().decode(Result.self, from: data!)
                self.timezone = result.timezone
                self.currentTime = result.current.dt
                self.temperature = Int(result.current.temp.rounded())
                self.summary = result.current.weather[0].description
                self.dailyIcon = self.fileNameForIcon(icon: result.current.weather[0].icon)
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
            completed()
        }
        
        task.resume()
    }
    
    func fileNameForIcon(icon: String) -> String {
        var newFileName = ""
        switch icon {
        case "01d", "01n":
            newFileName = "clear sky"
        case "02d", "02n":
            newFileName = "few clouds"
        case "03d", "03n":
            newFileName = "scattered clouds"
        case "04d", "04n":
            newFileName = "broken clouds"
        case "09d", "09n":
            newFileName = "shower rain"
        case "10d", "10n":
            newFileName = "rain"
        case "11d", "11n":
            newFileName = "thunderstorm"
        case "13d", "13n":
            newFileName = "snow"
        case "50d", "50n":
            newFileName = "mist"
        default:
            newFileName = ""
        }
        return newFileName
        
    }
}
