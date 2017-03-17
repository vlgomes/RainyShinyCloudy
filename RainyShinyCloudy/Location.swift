//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by Vasco Gomes on 24/10/2016.
//  Copyright © 2016 Vasco Gomes. All rights reserved.
//

import Foundation
import CoreLocation

class Location{
    
    static var sharedInstance = Location()
    
    private init(){
        
    }
    
    var latitude : Double!
    var longitude : Double!
}
