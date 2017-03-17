//
//  WeatherVC.swift
//  RainyShinyCloudy
//
//  Created by Vasco Gomes on 23/10/2016.
//  Copyright © 2016 Vasco Gomes. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var currenteWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    
    var currentWeather: CurrentWeather!
    
    var forecast: Forecast!
    
    var forecasts = [Forecast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        //we want the best accuracy possible for our gps
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //request authorization from user
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus()
    {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            //use of our singleton class
            if currentLocation != nil
            {
                Location.sharedInstance.latitude = currentLocation.coordinate.latitude
                Location.sharedInstance.longitude = currentLocation.coordinate.longitude

                currentWeather.downloadWeatherDetails{
                    self.downloadForecastData{
                        self.updateMainUI()
                    }
                }
            }
        }
        else {
            //if its not authorized, we will ask
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed : @escaping DownloadComplete)
    {
        //Alamofire download
        let forecastURL = URL (string : FORECAST_URL)!
//        print("\n\n\n\n\nFORECAST URL")
//        print(forecastURL)
//        
        Alamofire.request(forecastURL).responseJSON
        { response in
            let result = response.result
                
            if let dict = result.value as? Dictionary<String, AnyObject>{
                    
                if let list = dict["list"]as? [Dictionary<String, AnyObject>]
                {
                    //iterate throuhg the array in the object list in the JSON
                    for obj in list
                    {
                        let forecast = Forecast(weatherDict:obj)
                            
                        self.forecasts.append(forecast)
                    }
                    //to remove our current day, and show only after tomorrow
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell
        {
            let forecast = forecasts[indexPath.row]
            
            cell.configureCell(forecast: forecast)
            
            return cell
        }
        else {
            return WeatherCell()
        }
    }
    
    func updateMainUI()
    {
        dateLabel.text = currentWeather.date
        locationLabel.text = currentWeather._cityName
        currentTempLabel.text = "\(currentWeather._currentTemperature!)°"
        currentWeatherTypeLabel.text = currentWeather._weatherType
        
        //this works because the name of the images is equal to the name of the weather type
        currenteWeatherImage.image = UIImage(named:currentWeather._weatherType)
    }
    
}

