//
//  LiveLocationStatusService.swift
//  ISSRemix
//
//  Created by Hamza DOUMARI on 1/28/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation
import CoreLocation

protocol LiveLocationStatusServiceDelegate: AnyObject {
    func didUpdateMyLocations(location: CLLocation)
}

protocol LiveLocationStatusServiceProtocol: AnyObject {
    func setDelegate(delegate: LiveLocationStatusServiceDelegate)
}

class LiveLocationStatusService: NSObject {
    private let locationManager = CLLocationManager()
    private weak var delegate: LiveLocationStatusServiceDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
}

// MARK: - CLLocationManagerDelegate
extension LiveLocationStatusService: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let myLocation = locations.first else { return }
        delegate?.didUpdateMyLocations(location: myLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }
}

// MARK: - LiveLocationStatusServiceProtocol
extension LiveLocationStatusService: LiveLocationStatusServiceProtocol{
    func setDelegate(delegate: LiveLocationStatusServiceDelegate) {
        self.delegate = delegate
    }
}
