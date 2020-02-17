//
//  LocationManager.swift
//  birds-eye
//
//  Created by Brendan Campbell on 2/17/20.
//  Copyright © 2020 eecs497. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

class LocationManager : NSObject, ObservableObject {
    // Derive access to location services via CLLocationManager.
    // Expose location services by subscribing to our LocationManager.
    private let locationManager = CLLocationManager()

    // `Never` --> does not publish errors
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @Published var locationStatus: CLAuthorizationStatus? {
        // Notify subscriber
        willSet { objectWillChange.send() }
    }

    @Published var lastLocation: CLLocation? {
        // Notify subscriber
        willSet { objectWillChange.send() }
    }

    override init(){
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization
        status: CLAuthorizationStatus) {
        self.locationStatus = status
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations
        locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
        print(location.coordinate.latitude)
    }
}
