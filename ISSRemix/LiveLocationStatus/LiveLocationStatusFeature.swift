//
//  LiveLocationStatusFeature.swift
//  ISSRemix
//
//  Created by Hamza DOUMARI on 1/28/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation

class LiveLocationStatusFeature {
    static func make() -> LiveLocationStatusCoordinatorProtocol {
        let formatter = LiveLocationStatusFormatter()
        let interactor = LiveLocationStatusInteractor(service: LiveLocationStatusService())
        let view = LiveLocationStatusView.make()
        let deps = LiveLocationStatusCoordinator.Dependencies(formatter: formatter, interactor: interactor, view: view)
        return LiveLocationStatusCoordinator(dependencies: deps)
    }
}
