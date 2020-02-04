//
//  ISSLiveLocationViewController.swift
//  ISSRemix
//
//  Created by Hamza DOUMARI on 1/30/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import UIKit
import MapKit

protocol ISSLiveLocationFactory: AnyObject {
    static func makeView() -> ISSLiveLocationProtocol
}

protocol ISSLiveLocationProtocol: AnyObject {
    func updateLocation(location: CLLocation)
    func setDelegate(delegate: ISSLiveLocationDelegate)
    func showErrorMessage(message: String)
    func setISSStatusView(view: UIView)
}

protocol ISSLiveLocationDelegate: AnyObject {
    func viewIsReady()
}

class ISSLiveLocationViewController: UIViewController {
    
    private lazy var mapView: MKMapView = {
        return MKMapView()
    }()
    private lazy var iSSPosition: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
        annotation.title = "ISS POSITION"
        annotation.subtitle = "ISS POSITION SUBTITLE"
        return annotation
    }()
    private weak var delegate: ISSLiveLocationDelegate?
    private let regionRadius: CLLocationDistance = 10000000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMapView()
        delegate?.viewIsReady()
    }
    
    private func setMapView(){
        self.view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    }
}

// MARK: - ISSLiveLocationFactory
extension ISSLiveLocationViewController: ISSLiveLocationFactory{
    static func makeView() ->  ISSLiveLocationProtocol{
        return ISSLiveLocationViewController()
    }
}

// MARK: - ISSLiveLocationProtocol
extension ISSLiveLocationViewController: ISSLiveLocationProtocol{
    func setISSStatusView(view: UIView) {
        self.view.addSubview(view)
        view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        view.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 20).isActive = true
    }
    
    func showErrorMessage(message: String) {
        let alertMessage = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertMessage.addAction(action)
        DispatchQueue.main.async {
            self.present(alertMessage, animated: true, completion: nil)
        }
    }
    
    func setDelegate(delegate: ISSLiveLocationDelegate) {
        self.delegate = delegate
    }
    
    func updateLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        iSSPosition.coordinate = location.coordinate
        DispatchQueue.main.async {
            self.mapView.setRegion(coordinateRegion, animated: true)
            self.mapView.addAnnotation(self.iSSPosition)
        }
    }
}
