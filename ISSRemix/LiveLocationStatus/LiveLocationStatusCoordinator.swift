//
//  LiveLocationStatusCoordinator.swift
//  ISSRemix
//
//  Created by Hamza DOUMARI on 1/28/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol LiveLocationStatusCoordinatorProtocol {
    func updateISSLocation(location: CLLocation)
    func start() -> UIView?
}

class LiveLocationStatusCoordinator {
    struct Dependencies {
        let formatter: LiveLocationStatusFormatter
        let interactor: LiveLocationStatusInteractorProtocol
        let view: LiveLocationStatusViewProtocol
    }
    private let deps: Dependencies
    
    init(dependencies: Dependencies) {
        deps = dependencies
        deps.interactor.setDelegate(delegate: self)
    }
}

// MARK: - LiveLocationStatusInteractorDelegate
extension LiveLocationStatusCoordinator: LiveLocationStatusInteractorDelegate{
    func didRecieveNewStatus(status: LocationStatus) {
        let viewData = deps.formatter.prepareData(status: status)
        deps.view.updateColor(viewData: viewData)
    }
}

// MARK: - LiveLocationStatusCoordinatorProtocol
extension LiveLocationStatusCoordinator: LiveLocationStatusCoordinatorProtocol{
    func updateISSLocation(location: CLLocation) {
        deps.interactor.updateISSLocation(location: location)
    }
    
    func start() -> UIView? {
        return deps.view as? UIView
    }
}
