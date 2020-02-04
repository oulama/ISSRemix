//
//  LiveLocationStatusInteractor.swift
//  ISSRemix
//
//  Created by Hamza DOUMARI on 1/28/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation
import MapKit

enum LocationStatus {
    case noDataAvailable
    case isAbove
    case isNotAbove
    var localizedDescription: String{
        switch self {
        case .noDataAvailable: return "No Data Available"
        case .isAbove: return "Is Above"
        case .isNotAbove: return "Is Not Above"
        }
    }
}

protocol LiveLocationStatusInteractorDelegate: AnyObject {
    func didRecieveNewStatus(status: LocationStatus)
}

protocol LiveLocationStatusInteractorProtocol {
    func setDelegate(delegate: LiveLocationStatusInteractorDelegate)
    func updateISSLocation(location: CLLocation)
}

class LiveLocationStatusInteractor {
    private var myLocation: CLLocation?
    private var issLocation: CLLocation?
    private weak var delegate: LiveLocationStatusInteractorDelegate?
    private let service: LiveLocationStatusServiceProtocol?
    
    init(service: LiveLocationStatusServiceProtocol) {
        self.service = service
        service.setDelegate(delegate: self)
    }
    
    private func compareLocation(){
        guard let myLocation = myLocation, let issLocation = issLocation else {
            delegate?.didRecieveNewStatus(status: .noDataAvailable)
            return
        }
        let distanceInMeters = issLocation.distance(from: myLocation)
        self.delegate?.didRecieveNewStatus(status: distanceInMeters >= 1000000 ? .isNotAbove : .isAbove)
    }
}

// MARK: - LiveLocationStatusInteractorProtocol
extension LiveLocationStatusInteractor: LiveLocationStatusInteractorProtocol{
    func updateISSLocation(location: CLLocation){
        self.issLocation = location
        compareLocation()
    }
    
    func setDelegate(delegate: LiveLocationStatusInteractorDelegate){
        self.delegate = delegate
    }
}

// MARK: - LiveLocationStatusServiceDelegate
extension LiveLocationStatusInteractor: LiveLocationStatusServiceDelegate{
    func didUpdateMyLocations(location: CLLocation) {
        myLocation = location
        compareLocation()
    }
}
