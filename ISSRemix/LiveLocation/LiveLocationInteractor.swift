//
//  LiveLocationInteractor.swift
//  ISSRemix
//
//  Created by Hamza DOUMARI on 1/27/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation

protocol LiveLocationInteractorDelegate: AnyObject {
    func didFectchISSLiveLocation(location: Location?)
    func didFectchISSLiveLocation(with message: String)
}

class LiveLocationInteractor {
    private weak var delegate: LiveLocationInteractorDelegate?
    private let service: LiveLocationServiceProtocol?
    
    init(service: LiveLocationServiceProtocol) {
        self.service = service
    }
    
    func setDelegate(delegate: LiveLocationInteractorDelegate){
        self.delegate = delegate
    }
    
    func fetchISSLiveLocation(){
        service?.getISSLiveLocation(completion: { (result) in
            switch result{
            case .success(let response):
                guard let location = response.iss_position else{ return }
                self.delegate?.didFectchISSLiveLocation(location: location)
            case .failure(let error):
                self.delegate?.didFectchISSLiveLocation(with: error.localizedDescription)
            }
        })
    }
}

