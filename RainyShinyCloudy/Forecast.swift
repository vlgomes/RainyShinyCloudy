//
//  Forecast.swift
//  RainyShinyCloudy
//
//  Created by Vasco Gomes on 24/10/2016.
//  Copyright © 2016 Vasco Gomes. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    var _date : String!
    var _weatherType : String!
    var _highTemperature : String!
    var _lowTemperature : String!
    
    var date: String {
        if _date == nil{
            _date = ""
        }
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil{
            _weatherType = ""
        }
        
        return _weatherType
    }

    var highTemperature: String {
        if _highTemperature == nil{
            _highTemperature = ""
        }
        
        return _highTemperature
    }

    var lowTemperature: String {
        if _lowTemperature == nil{
            _lowTemperature = ""
        }
        
        return _lowTemperature
    }
    
    init(weatherDict: Dictionary<String,AnyObject>)
    {
        if let dict=weatherDict["temp"] as? Dictionary<String,AnyObject>
        {
            if let minTemperature = dict["min"] as? Double
            {
                self._lowTemperature = kelvinToCelsiusToString(kelvin:minTemperature)
            }
            
            if let maxTemperature = dict["max"] as? Double
            {
                self._highTemperature = kelvinToCelsiusToString(kelvin:maxTemperature)
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>]{
            
            if let main = weather[0]["main"] as? String
            {
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double{
            
            let unixConvertedDate=Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat="EEEE"
            dateFormatter.timeStyle = .none
            
            //passing throuhg the function everything and returning only the day of the week
            self._date=unixConvertedDate.dayOfWeek()
            
        }
    }
    
    func kelvinToCelsiusToString(kelvin : Double) -> String!{
        
        let celsius = kelvin-273.15
        
        return "\(Double(round(100*celsius)/100))"
    }
}

extension Date{
    func dayOfWeek() ->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat="EEEE"
        return dateFormatter.string(from:self)
    }
}
