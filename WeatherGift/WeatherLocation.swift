//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Richard Shum on 10/10/21.
//

import Foundation

class WeatherLocation: Codable{
    var name: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getData() {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&appid=\(APIkeys.openWeatherKey)"
        
        print("We are access the URL \(urlString)")
        
        // Create a URL
        guard let url = URL(string: urlString) else {
            print("Error: Could not create an URL from \(urlString)")
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
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("\(json)")
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
