//
//  Constants.swift
//  RainyShinyCloudy
//
//  Created by Vasco Gomes on 24/10/2016.
//  Copyright © 2016 Vasco Gomes. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APPID = "&appid="
let APIKEY = "20bf5a1a234cd2b68a2bff600990fbe1"

typealias DownloadComplete = () -> ()

let CURRENTWEATHERURL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APPID)\(APIKEY)"

let FORECAST_BASEURL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let MIDDLEFORECASTURL = "&cnt=10&mode=json&"


let FORECAST_URL = "\(FORECAST_BASEURL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(MIDDLEFORECASTURL)\(APPID)\(APIKEY)"


