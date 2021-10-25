//
//  HourlyCollectionViewCell.swift
//  WeatherGift
//
//  Created by Richard Shum on 10/25/21.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var hourlyLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var hourlyTemperature: UILabel!
    
    var hourlyWeather: HourlyWeather! {
        didSet {
            hourlyLabel.text = hourlyWeather.hour
            iconImageView.image = UIImage(systemName: hourlyWeather.hourlyIcon)
            hourlyTemperature.text = "\(hourlyWeather.hourlyTemperature)°"
        }
    }
}
