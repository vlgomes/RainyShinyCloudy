//
//  CurrentWeather.swift
//  RainyShinyCloudy
//
//  Created by Vasco Gomes on 24/10/2016.
//  Copyright © 2016 Vasco Gomes. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather
{
    var _cityName : String!
    var _date : String!
    var _weatherType : String!
    var _currentTemperature : Double!
    
    var cityName: String {
        if _cityName == nil{
            _cityName = ""
        }
        
        return _cityName
    }
    
    var date: String
    {
        if _date == nil{
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        
        //the full name of the month, day and year
        dateFormatter.dateStyle = .long
        //we don't want time, and since time is returned by default, we have to handle it
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        
        self._date = "Today \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil{
            _weatherType = ""
        }
        
        return _cityName
    }
    
    var currentTemperature: Double {
        if _currentTemperature == nil{
            _currentTemperature = 0.0
        }
        
        return _currentTemperature
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete)
    {
        //Alamofire download
        let currentWeatherURL = URL (string : CURRENTWEATHERURL)
        
//        print("\n\n\n\n\nCURRENT WEATHER URL")
//        print(currentWeatherURL)
        
        Alamofire.request(currentWeatherURL!).responseJSON
        { response in
            let result = response.result
            
            //put the result inside a dictionray
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let name = dict["name"] as? String{
                    //assuring that the 1st letter of the city is allways Capitalized
                    self._cityName = name.capitalized
                    //print("\n\n\n CITYNAME - \(self._cityName!)")
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main.capitalized
                        //print("\n\n\n WEATHER TYPE - \(self._weatherType!)")
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject>{
                    
                    if let currentTemperature = main["temp"] as? Double
                    {
                        let kelvinToCelsius = currentTemperature - 273.15
                        
                        self._currentTemperature = Double(round(100*kelvinToCelsius)/100)
                        //print("\n\n\n CURRENT TEMPERATURE - \(self._currentTemperature!)")
                    }
                }
            }
            completed()
        }
    }
}
