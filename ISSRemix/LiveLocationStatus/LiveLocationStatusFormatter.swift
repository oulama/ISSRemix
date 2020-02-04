//
//  LiveLocationStatusFormatter.swift
//  ISSRemix
//
//  Created by Hamza DOUMARI on 1/28/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import UIKit

struct LiveLocationStatusViewData {
    
    var color: UIColor?
    var message: String?
}

class LiveLocationStatusFormatter {
    func prepareData(status: LocationStatus) -> LiveLocationStatusViewData{
        switch status {
        case .isAbove:
            return LiveLocationStatusViewData(color: UIColor.green, message: status.localizedDescription)
        case .isNotAbove:
            return LiveLocationStatusViewData(color: UIColor.red, message: status.localizedDescription)
        case .noDataAvailable:
            return LiveLocationStatusViewData(color: UIColor.yellow, message: status.localizedDescription)
        }
    }
}
