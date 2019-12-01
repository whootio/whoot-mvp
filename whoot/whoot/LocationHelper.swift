//
//  LocationHelper.swift
//  whoot
//
//  Created by Andres Gonzales on 12/1/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class LocationHelper: NSObject,CLLocationManagerDelegate{
    
    let locationManager =  CLLocationManager()
    
    func getLocation(){
        locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }


    
    
    
    
    
}
