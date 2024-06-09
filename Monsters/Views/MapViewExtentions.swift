

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

extension MapViewController {
    
    func buttonStyle() {
        myTeamButton.MyOwnButtonStile(setTitle: Resources.Strings.myTeamButtonTitle, fontSize: 18)
        locationButton.stileForLocationButton()
        
        questionButton.questionButton()

        questionMark.isUserInteractionEnabled = false
        questionMark.animationSpeed = 0.5
        questionMark.loopMode = .loop
        questionMark.play()
        questionButton.addSubview(questionMark)
        questionMark.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        animationPoint.isUserInteractionEnabled = true
        animationPoint.animationSpeed = 0.5

        animationPoint.loopMode = .loop
        animationPoint.play()
        
        heartViewAnimate.isUserInteractionEnabled = true
        heartViewAnimate.animationSpeed = 0.5

        heartViewAnimate.loopMode = .loop
        heartViewAnimate.play()
        
        zoomInButton.MyOwnButtonStile(setTitle: "+", fontSize: 20)
        zoomOutButton.MyOwnButtonStile(setTitle: "－", fontSize: 20)

    }
    
    func addActionToButton() {

        locationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        myTeamButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        questionButton.addTarget(self, action: #selector(questionButtonAction), for: .touchUpInside)
        zoomInButton.addTarget(self, action: #selector(zoomInButtonTapped), for: .touchUpInside)
        zoomOutButton.addTarget(self, action: #selector(zoomOutButtonTapped), for: .touchUpInside)
    }
    
    @objc func questionButtonAction() {

        self.navigationController?.pushViewController(QuestionViewController(), animated: true)
        
    }
    
    @objc func locationButtonTapped() {
        updateUserLocation(to: locationManager.location ?? CLLocation() , with: Resources.Strings.userLocationTitle)
 
    }
    
    @objc func buttonTapped() {
        let myTeamVC = MyTeamViewController()
            myTeamVC.capturedMonsters = capturedMonsters
        navigationController?.pushViewController(myTeamVC, animated: true)
        capturedMonsters.forEach { monster in
            print("\(monster.name), \(monster.subtitle)")
        }
    }
    
    @objc func zoomInButtonTapped() {
        var region = mapView.region
        region.span.latitudeDelta *= 0.75
        region.span.longitudeDelta *= 0.75
        mapView.setRegion(region, animated: true)
    }

    @objc func zoomOutButtonTapped() {
        var region = mapView.region
        region.span.latitudeDelta /= 0.75
        region.span.longitudeDelta /= 0.75
        mapView.setRegion(region, animated: true)
    }
    
    
}
