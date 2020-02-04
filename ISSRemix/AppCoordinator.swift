//
//  AppCoordinator.swift
//  ISSRemix
//
//  Created by Hamza DOUMARI on 1/27/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator {
    private var window: UIWindow?
    private var coordinator: LiveLocationCoordinator?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start(){
        coordinator = LiveLocationFeature.make(connection: APIClient())
        self.window?.rootViewController = coordinator?.start()
    }
}
