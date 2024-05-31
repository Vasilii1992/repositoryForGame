
import Foundation
import UIKit
import MapKit
import CoreLocation
import Lottie

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        if currentCoordinate == nil {
            centerViewOnUserLocation()
            addHeartAnnotations()

            addAnnotation(with: 30)
        }
        currentCoordinate = location.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let title = annotation.title else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Resources.Identifiers.identifierForAnnotation)
        
        if (annotationView == nil) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: Resources.Identifiers.identifierForAnnotation)
        }
        
        if let monster = monsters.first(where: { $0.name == title }) {
            annotationView?.image = UIImage(named: monster.imageName)
            annotationView?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        } else if (annotation === mapView.userLocation) {
            annotationView?.image = UIImage(named: "Hero2")
            annotationView?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            annotationView?.addSubview(animationPoint)
            animationPoint.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

            let heroImageView = UIImageView(image: UIImage(named: "Hero2"))
            heroImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            annotationView?.addSubview(heroImageView)

            animationPoint.center = CGPoint(x: annotationView!.bounds.size.width / 2, y: annotationView!.bounds.size.height / 2)
        } else if (title == "Heart") {
            annotationView?.image = heartView
            annotationView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        }
        
        annotationView?.canShowCallout = true
        
        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if let title = view.annotation?.title, title == "Heart", let userLocation = mapView.userLocation.location {
            let heartLocation = CLLocation(latitude: view.annotation!.coordinate.latitude, longitude: view.annotation!.coordinate.longitude)
            let distance = userLocation.distance(from: heartLocation)
            if distance <= 100 {
                addHeart()
                mapView.removeAnnotation(view.annotation!)
            } else {
                notCaughtLabel.createNewLabel(text: Resources.Strings.heartString, color: color, size: 20)
                notCaughtLabel.text = Resources.Strings.heartString + " \(Int(distance))" + Resources.Strings.meters
                notCaughtLabel.center = self.view.center
                notCaughtLabel.frame.origin.y += 80
                notCaughtLabel.alpha = 0.0
                let fixedWidth: CGFloat = 250
                let size = CGSize(width: fixedWidth, height: .infinity)
                let estimatedSize = notCaughtLabel.sizeThatFits(size)
                notCaughtLabel.frame = CGRect(x: 70, y: 400, width: fixedWidth, height: estimatedSize.height)
                self.view.addSubview(notCaughtLabel)
                UIView.animate(withDuration: 1.0, animations: {
                    self.notCaughtLabel.alpha = 1.0
                }) { _ in
                    UIView.animate(withDuration: 3.0, animations: {
                        self.notCaughtLabel.alpha = 0.0
                    }) { _ in
                        self.notCaughtLabel.removeFromSuperview()
                    }
                }
            }
        } else if let monsterAnnotation = view.annotation as? MonsterAnnotation {
            if let userLocation = mapView.userLocation.location {
                let monsterLocation = CLLocation(latitude: monsterAnnotation.coordinate.latitude, longitude: monsterAnnotation.coordinate.longitude)
                let distance = userLocation.distance(from: monsterLocation)
                if distance <= 100 {
                    let newVC = CatchViewController(monster: monsterAnnotation.monster, heartViews: heartViews)
                    newVC.delegate = self
                    newVC.monster = monsterAnnotation.monster
                    newVC.caughtLabel.text = "\(monsterAnnotation.monster.name)" + Resources.Strings.caught
                    newVC.caughtLabel.sizeToFit()
                    newVC.monsterImage = UIImage(named: monsterAnnotation.monster.imageName)
                    navigationController?.pushViewController(newVC, animated: true)
                } else {
                    notCaughtLabel.createNewLabel(text: Resources.Strings.monsterString, color: color, size: 20)
                    notCaughtLabel.text = Resources.Strings.monsterString + " \(Int(distance))" + Resources.Strings.meters
                    notCaughtLabel.center = self.view.center
                    notCaughtLabel.frame.origin.y += 80
                    notCaughtLabel.alpha = 0.0
                    let fixedWidth: CGFloat = 250
                    let size = CGSize(width: fixedWidth, height: .infinity)
                    let estimatedSize = notCaughtLabel.sizeThatFits(size)
                    notCaughtLabel.frame = CGRect(x: 70, y: 400, width: fixedWidth, height: estimatedSize.height)
                    self.view.addSubview(notCaughtLabel)
                    UIView.animate(withDuration: 1.0, animations: {
                        self.notCaughtLabel.alpha = 1.0
                    }) { _ in
                        UIView.animate(withDuration: 3.0, animations: {
                            self.notCaughtLabel.alpha = 0.0
                        }) { _ in
                            self.notCaughtLabel.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }
}
