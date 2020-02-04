//
//  LiveLocationFeature.swift
//  ISSRemix
//
//  Created by Hamza DOUMARI on 1/27/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation

class LiveLocationFeature {
    static func make(connection: APIClient) -> LiveLocationCoordinator{
        let view = ISSLiveLocationViewController.makeView()
        let service = LiveLocationService(connection: connection)
        let interactor = LiveLocationInteractor(service: service)
        let formatter = LiveLocationFormatter()
        let deps = LiveLocationCoordinator.Dependencies(view: view, interactor: interactor, formatter: formatter)
        return LiveLocationCoordinator(deps: deps)
    }
}
