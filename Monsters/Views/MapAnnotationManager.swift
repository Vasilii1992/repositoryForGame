//
//  MapAnnotationManager.swift
//  Monsters
//
//  Created by Василий Тихонов on 09.06.2024.
//

import Foundation
import MapKit

class MapAnnotationManager {
    private let mapView: MKMapView
    private let locationManager: CLLocationManager
    private let regionInMeters: Double

    init(mapView: MKMapView, locationManager: CLLocationManager, regionInMeters: Double) {
        self.mapView = mapView
        self.locationManager = locationManager
        self.regionInMeters = regionInMeters
    }

    func addHeartAnnotations(with heartImage: UIImage?) {
        guard let currentLocation = locationManager.location else { return }
        for _ in 1...5 {
            let latitudeOffset = Double.random(in: -0.005...0.005)
            let longitudeOffset = Double.random(in: -0.005...0.005)
            let randomLatitude = currentLocation.coordinate.latitude + latitudeOffset
            let randomLongitude = currentLocation.coordinate.longitude + longitudeOffset
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: randomLatitude, longitude: randomLongitude)
            annotation.title = "Heart"
            mapView.addAnnotation(annotation)
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "heart")
            annotationView.image = heartImage
            mapView.addAnnotation(annotationView.annotation!)
        }
    }

    func addAnnotation(with count: Int) {
        if let currentLocation = locationManager.location {
            let region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
            for _ in 1...count {
                let latitudeOffset = Double.random(in: -0.0089...0.0089)
                let longitudeOffset = Double.random(in: -0.0089...0.0089)
                let levelRandom = Int.random(in: 1...10)
                let randomLatitude = currentLocation.coordinate.latitude + latitudeOffset
                let randomLongitude = currentLocation.coordinate.longitude + longitudeOffset
                let randomMonster = monsters.randomElement()!
                let monster = Monster(name: randomMonster.name, subtitle: randomMonster.subtitle + String(levelRandom), imageName: randomMonster.imageName, latitude: randomLatitude, longitude: randomLongitude, backgraund: randomMonster.backgraund)
                let monsterAnnotation = MonsterAnnotation(monster: monster)
                mapView.addAnnotation(monsterAnnotation)
            }
        }
    }
    
    func updateAnnotations() {
           let shouldRemoveMonster = { return Int.random(in: 1...5) == 1 } // 20% chance to remove a monster from the map
           var annotationsToRemove: [MKAnnotation] = []
           let annotationsToAdd: [MKAnnotation] = []

           for annotation in mapView.annotations {
               if let monsterAnnotation = annotation as? MonsterAnnotation {
                   if shouldRemoveMonster() {
                       annotationsToRemove.append(monsterAnnotation)
                   }
               }
           }

           addAnnotation(with: 6)

           mapView.removeAnnotations(annotationsToRemove)
           mapView.addAnnotations(annotationsToAdd)
       }
}
