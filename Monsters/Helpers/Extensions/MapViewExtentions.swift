//
//  MapViewExtentions.swift
//  Monsters
//
//  Created by Василий Тихонов on 17.04.2023.
//

import UIKit
import MapKit
import CoreLocation
import Lottie

extension MapViewController {

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.checkLocationAuthorization()
                self.setupLocationManager()
            } else {
                Alert.showAlert(viewController: self, title: Resources.CheckLocationServices.geolocationTurnedOff, message: Resources.CheckLocationServices.enableIt)
            }
        }
    }

    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            Alert.showAlert(viewController: self, title: Resources.CheckLocationServices.turnedOffGeo, message: Resources.CheckLocationServices.settingsToEnable)
        case .authorizedAlways:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    func setupConstraints() {
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        myTeamButton.translatesAutoresizingMaskIntoConstraints = false
        zoomInButton.translatesAutoresizingMaskIntoConstraints = false
        zoomOutButton.translatesAutoresizingMaskIntoConstraints = false
        questionButton.translatesAutoresizingMaskIntoConstraints = false

    
          NSLayoutConstraint.activate([

            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            locationButton.topAnchor.constraint(equalTo: view.topAnchor,constant: 140),
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            locationButton.heightAnchor.constraint(equalToConstant: 50),
            locationButton.widthAnchor.constraint(equalToConstant: 50),
            
            
            questionButton.topAnchor.constraint(equalTo: view.topAnchor,constant: 80),
            questionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            questionButton.heightAnchor.constraint(equalToConstant: 50),
            questionButton.widthAnchor.constraint(equalToConstant: 50),
            

            zoomInButton.topAnchor.constraint(equalTo: view.topAnchor,constant: 250),
            zoomInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            zoomInButton.heightAnchor.constraint(equalToConstant: 50),
            zoomInButton.widthAnchor.constraint(equalToConstant: 50),
            
            zoomOutButton.topAnchor.constraint(equalTo: view.topAnchor,constant: 310),
            zoomOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            zoomOutButton.heightAnchor.constraint(equalToConstant: 50),
            zoomOutButton.widthAnchor.constraint(equalToConstant: 50),
            
            
            myTeamButton.heightAnchor.constraint(equalToConstant: 48),
            myTeamButton.widthAnchor.constraint(equalToConstant: 344),
            myTeamButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myTeamButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -15),
            
       
            
          ])
      }
    
    
    
    
}

