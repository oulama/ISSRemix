//
//  LiveLocationFormatter.swift
//  ISSRemix
//
//  Created by Hamza DOUMARI on 1/27/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation
import MapKit

class LiveLocationFormatter {
    func prepareData(location: Location?) -> CLLocation?{
        guard let latitude = location?.latitude, let longitude = location?.longitude else{ return nil }
        guard let cLLatitude = Double(latitude), let cLLongitude = Double(longitude) else {return nil }
        return CLLocation(latitude: cLLatitude, longitude: cLLongitude)
    }
}
