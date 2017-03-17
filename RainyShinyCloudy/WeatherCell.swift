//
//  WeatherCell.swift
//  RainyShinyCloudy
//
//  Created by Vasco Gomes on 24/10/2016.
//  Copyright © 2016 Vasco Gomes. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    func configureCell(forecast:Forecast)
    {
        lowTemp.text = "\(forecast.lowTemperature)"
        highTemp.text = "\(forecast.highTemperature)"
        weatherType.text = forecast.weatherType
        dayLabel.text = forecast.date
        weatherIcon.image = UIImage(named:forecast.weatherType)
    }
}
