//
//  LocationManager.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 21/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
import CoreLocation

typealias LocationManagerBlock = (_ location: CLLocation?,_ error: LocationManagerCode.error?) -> Void

protocol LocationHandler {
    func getCurrentLocation( completion: @escaping LocationManagerBlock)
    func fetchCityAndCountry(lattitude: Double,longitude: Double, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ())
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ())
}

class LocationManager : NSObject, LocationHandler {
    private let locationManager: CLLocationManager
    private var completionBlock : LocationManagerBlock?
    
     init(manager: CLLocationManager = CLLocationManager()) {
        locationManager = manager
        super.init()
    }
    
    func getCurrentLocation( completion: @escaping LocationManagerBlock) {
        completionBlock = completion
        
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .denied,.restricted:
                completionBlock!(nil,LocationManagerCode.error.accessDeniedByUser)
                
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.requestLocation()
                
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            default:
                locationManager.requestWhenInUseAuthorization()
            }
        } else {
            completionBlock!(nil,LocationManagerCode.error.locationServicesNotEnableOnDevice)
        }
    }
}

extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        completionBlock!(locations.first,nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied,.restricted:
            completionBlock!(nil,LocationManagerCode.error.accessDeniedByUser)
            
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .notDetermined:
            completionBlock!(nil,LocationManagerCode.error.failed)
        default:
            completionBlock!(nil,LocationManagerCode.error.accessDeniedByUser)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completionBlock!(nil,LocationManagerCode.error.failed)
    }
    
}

extension LocationManager {
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
     func fetchCityAndCountry(lattitude: Double,longitude: Double, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        let location = CLLocation(latitude: lattitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
}

struct LocationManagerCode {
    enum error : Error {
        case locationServicesNotEnableOnDevice
        case accessDeniedByUser
        case failed
    }
}
