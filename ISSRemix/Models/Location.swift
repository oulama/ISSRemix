//
//  Location.swift
//  ISSRemix
//
//  Created by Hamza DOUMARI on 1/27/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation

struct Location: Decodable {
    let longitude: String?
    let latitude: String?
}

struct APIResponseLocation: Decodable {
    let iss_position: Location?
    let message: String?
    
}
