//
//  LiveLocationService.swift
//  ISSRemix
//
//  Created by Hamza DOUMARI on 1/27/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation

protocol LiveLocationServiceProtocol: AnyObject {
    func getISSLiveLocation(completion: @escaping completionSignature)
}

typealias completionSignature = (Result<APIResponseLocation, APIError>) -> Void

class LiveLocationService{

    private var apiClient: APIClient
    
    init(connection: APIClient) {
        apiClient = connection
    }

}

// MARK: - LiveLocationServiceProtocol
extension LiveLocationService: LiveLocationServiceProtocol{
    
    func getISSLiveLocation(completion: @escaping  completionSignature) {
        guard let url = URL(string: ISSAPI.urlGetLiveLocation) else{ return }
        let urlRequest = URLRequest(url: url)
        apiClient.get(url: urlRequest, completion: completion)
    }
}
