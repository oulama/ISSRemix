//
//  LiveLocationCoordinator.swift
//  ISSRemix
//
//  Created by Hamza DOUMARI on 1/27/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation
import UIKit


class LiveLocationCoordinator {
    struct Dependencies {
        let view: ISSLiveLocationProtocol
        let interactor: LiveLocationInteractor
        let formatter: LiveLocationFormatter
    }
    
    private let deps: Dependencies
    private var liveLocationStatusCoordinator: LiveLocationStatusCoordinatorProtocol?
    private lazy var timer: Timer = {
        let timer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(fetchISSLiveLocation), userInfo: nil, repeats: true)
        return timer
    }()
    
    init(deps: Dependencies) {
        self.deps = deps
        deps.view.setDelegate(delegate: self)
        deps.interactor.setDelegate(delegate: self)
    }
    
    func start() -> UIViewController? {
        return deps.view as? UIViewController
    }
    
    @objc private func fetchISSLiveLocation(){
        deps.interactor.fetchISSLiveLocation()
    }
}

// MARK: - LiveLocationDelegate
extension LiveLocationCoordinator: ISSLiveLocationDelegate{

    func viewIsReady() {
        liveLocationStatusCoordinator = LiveLocationStatusFeature.make()
        guard let statusView = liveLocationStatusCoordinator?.start() else {return}
        deps.view.setISSStatusView(view: statusView)
        timer.fire()
    }
}

// MARK: - LiveLocationInteractorDelegate
extension LiveLocationCoordinator: LiveLocationInteractorDelegate{
    func didFectchISSLiveLocation(location: Location?) {
        guard let cLLocation = deps.formatter.prepareData(location: location) else{ return }
        deps.view.updateLocation(location: cLLocation)
        liveLocationStatusCoordinator?.updateISSLocation(location: cLLocation)
    }
    
    func didFectchISSLiveLocation(with message: String) {
        deps.view.showErrorMessage(message: message)
    }
}
