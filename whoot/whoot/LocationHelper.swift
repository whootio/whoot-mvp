//
//  LocationHelper.swift
//  whoot
//
//  Created by Andres Gonzales on 12/1/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//



import Foundation
import CoreLocation

protocol LocationUpdateProtocol {
    func locationDidUpdateToLocation(location : CLLocation)
}
let kLocationDidChangeNotification = "LocationDidChangeNotification"

class locationHelper:NSObject,CLLocationManagerDelegate{
    
    static let SharedManager = locationHelper()
    let locationManager = CLLocationManager()
    
    
    var currentLocation : CLLocation?
    var delegate : LocationUpdateProtocol!
    
    public var lat = 0.0
    public var lon = 0.0
    
    public override init(){
        super.init()
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        
        }
        //print("locations = \(loc.temp[0]) \(temp[1])")
        //return temp;
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        lat = locValue.latitude
        lon = locValue.longitude
    }
    
//    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
//        currentLocation = newLocation
//        let userInfo : NSDictionary = ["location" : currentLocation!]
//
//        DispatchQueue.main.async  { () -> Void in
//            self.delegate.locationDidUpdateToLocation(location: self.currentLocation!)
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kLocationDidChangeNotification), object: self, userInfo: userInfo as [NSObject : AnyObject])
//        }
//    }
    
}

