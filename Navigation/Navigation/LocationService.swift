//
//  LocationService.swift
//  Navigation
//
//  Created by Sergey on 09.09.2024.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {
    
    private var locationManager: CLLocationManager
    
    private var completion: ((CLLocation) -> Void)?
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
    }
    
    private func requestPermission() {
        locationManager.requestAlwaysAuthorization()
    }
    
    func getLocation(completion: @escaping ((_ location: CLLocation?) -> Void)) {
        self.completion = completion
        requestPermission()
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }
    
    func getNameFor(location: CLLocation, completion: @escaping ((String?) -> Void)) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: .current) { placemarks, error in
            guard error == nil, let place = placemarks?.first else {
                completion(nil)
                return
            }
            let name = place.name
            completion(name)
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            requestPermission()
        case .denied:
            print("access denied")
        case .restricted:
            print("access restricted")
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        @unknown default:
            print("error")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            completion?(location)
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
