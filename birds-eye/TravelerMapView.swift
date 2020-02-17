//
//  TravelerMapView.swift
//  birds-eye
//
//  Created by Brendan Campbell on 2/17/20.
//  Copyright © 2020 eecs497. All rights reserved.
//

import SwiftUI
import MapKit

struct TravelerMapView: UIViewRepresentable {
    @ObservedObject var locationManager = LocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        var coordinate: CLLocationCoordinate2D
        if let auth = locationManager.locationStatus, auth == .authorizedAlways || auth == .authorizedWhenInUse {
            coordinate = locationManager.lastLocation?.coordinate ?? CLLocationCoordinate2D(
            latitude: 34.011286, longitude: -116.166868)
        } else {
            coordinate = CLLocationCoordinate2D(
            latitude: 34.011286, longitude: -116.166868)
        }
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

struct TravelerMapView_Previews: PreviewProvider {
    static var previews: some View {
        TravelerMapView()
    }
}
