//
//  LocationHelper.swift
//  whoot
//
//  Created by Andres Gonzales on 12/1/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//

import Foundation
import CoreLocation


class LocationHelper:NSObject,CLLocationManagerDelegate{
    let locationManager = CLLocationManager()
    
    
    
    func getLoc(){
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    
}
