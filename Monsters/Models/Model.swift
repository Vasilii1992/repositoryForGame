
import Foundation
import MapKit



struct Monster: Equatable,Encodable,Decodable {
    let name: String
    let subtitle: String
    let imageName: String
    var latitude: Double
    var longitude: Double
    let backgraund: String
}

final class MonsterAnnotation: MKPointAnnotation {
    let monster: Monster

    init(monster: Monster) {
        self.monster = monster
        super.init()
        self.title = monster.name
        self.subtitle = monster.subtitle
        self.coordinate = CLLocationCoordinate2D(latitude: monster.latitude, longitude: monster.longitude)
    }
}


var monsters = [
    Monster(name: Resources.MonsterName.godzilla, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.godzilla, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.godzilla),
    Monster(name: Resources.MonsterName.ghost, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.ghost, latitude: 59.93358487887655, longitude: 30.35071790935886, backgraund: Resources.MonsterBackgraund.ghost),
    Monster(name: Resources.MonsterName.slept, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.slept, latitude: 59.931509638232065, longitude: 30.358925674068285, backgraund: Resources.MonsterBackgraund.slept),
    Monster(name: Resources.MonsterName.serp, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.serp, latitude: 59.93967302105203, longitude: 30.340245368497094, backgraund: Resources.MonsterBackgraund.serp),
    Monster(name: Resources.MonsterName.morder, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.morder, latitude: 59.935527508674184, longitude: 30.36491185671947, backgraund: Resources.MonsterBackgraund.morder),
    Monster(name: Resources.MonsterName.drakosha, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.drakosha, latitude: 59.89157811298915, longitude: 30.424140876531627, backgraund: Resources.MonsterBackgraund.drakosha),
    Monster(name: Resources.MonsterName.sad, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.sad, latitude: 59.9358777789229, longitude: 30.3219035565975, backgraund: Resources.MonsterBackgraund.sad),
    Monster(name: Resources.MonsterName.toots, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.toots, latitude: 59.23487, longitude: 30.32190, backgraund: Resources.MonsterBackgraund.toots),
    Monster(name: Resources.MonsterName.glazastic, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.glazastic, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.glazastic),
    Monster(name: Resources.MonsterName.goblin, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.goblin, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.goblin),
    Monster(name: Resources.MonsterName.bigguy, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.bigguy, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.bigguy),
    Monster(name: Resources.MonsterName.sparrow, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.sparrow, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.sparrow),
    Monster(name: Resources.MonsterName.jack, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.jack, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.jack),
    Monster(name: Resources.MonsterName.soulrender, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.soulrender, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.soulrender),
    Monster(name: Resources.MonsterName.hexmire, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.hexmire, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.hexmire),
    Monster(name: Resources.MonsterName.doomshriek, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.doomshriek, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.doomshriek),
    Monster(name: Resources.MonsterName.frostclaw, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.frostclaw, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.frostclaw),
    Monster(name: Resources.MonsterName.embermaw, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.embermaw, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.embermaw),
    Monster(name: Resources.MonsterName.venomtide, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.venomtide, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.venomtide),
    Monster(name: Resources.MonsterName.vortexlash, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.vortexlash, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.vortexlash),
    Monster(name: Resources.MonsterName.craggnar, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.craggnar, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.craggnar),
    Monster(name: Resources.MonsterName.shadowspire, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.shadowspire, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.shadowspire),
    Monster(name: Resources.MonsterName.gloomfang, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.gloomfang, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.gloomfang),


]

/*
 добавь "updateAnnotations" в "MapAnnotationManager"
 
 Ты IOS разрабодчик. У нас есть проект в котором нет архитектуры. Необходимо постараться вынести бизнес логику метода "updateHeartViewConstraints" за пределы View.
 Вот код приложения:
 
 You're an iOS developer. We have a project in which there is no architecture. It is necessary to try to take the business logic of the "updateHeartViewConstraints" method outside the View.
  Here is the application code:
 
 import UIKit
 import MapKit
 import CoreLocation
 import Lottie

 protocol MonsterCaptureDelegate: AnyObject {
     func didCaptureMonster(_ monster: Monster)
     func didEscapeMonster(_ monster: Monster)
     func updateHeart()
 }


 final class MapViewController: UIViewController,MonsterCaptureDelegate {


     var heartViews = [LottieAnimationView]()
     var heartCount = 3
         
     let heartView = UIImage(named: "heart")
     
     var mapView = MKMapView()
     var capturedMonsters: [Monster] = [] {
         didSet {
             myTeamViewController?.capturedMonsters = capturedMonsters
             myTeamViewController?.tableView.reloadData()
             let userDefaults = UserDefaults.standard
             let encodedData = try? JSONEncoder().encode(capturedMonsters)
             userDefaults.set(encodedData, forKey: "capturedMonsters")
         }
     }
     
     var escapedMonsters: [Monster] = []

     weak var myTeamViewController: MyTeamViewController?
     weak var catchViewContriller: CatchViewController?
      var currentCoordinate: CLLocationCoordinate2D?
     private var timer: Timer?
     let zoomInButton = UIButton()
     let zoomOutButton = UIButton()
     let locationButton = UIButton()
     
     let questionButton = UIButton()
     
     let animationPoint: LottieAnimationView = {
         let animation = LottieAnimationView(name: "pointGreen")
         animation.contentMode = .scaleAspectFit
         return animation
     }()
     
     let questionMark: LottieAnimationView = {
         let animation = LottieAnimationView(name: "question-mark")
         animation.contentMode = .scaleAspectFit
         return animation
     }()
     let heartViewAnimate: LottieAnimationView = {
         let animation = LottieAnimationView(name: "heartPoint")
         animation.contentMode = .scaleAspectFit
         return animation
     }()
     let myTeamButton = UIButton()
     let locationManager = CLLocationManager()
     let regionInMeters: Double = 300
     let color = #colorLiteral(red: 0.1607843041, green: 0.1607843041, blue: 0.1607843041, alpha: 1)
     let notCaughtLabel = UILabel()

     override func viewDidLoad() {
         super.viewDidLoad()

         if let savedHeartCount = UserDefaults.standard.value(forKey: "heartCount") as? Int {
             heartCount = savedHeartCount
         }

        
          let userDefaults = UserDefaults.standard
          if let savedData = userDefaults.object(forKey: "capturedMonsters") as? Data,
             let decodedData = try? JSONDecoder().decode([Monster].self, from: savedData) {
              capturedMonsters = decodedData
          }
         
         createHeartForDisplay()
         updateHeartViewConstraints()
         
         addActionToButton()
         buttonStyle()
         checkLocationServices()
         setupViews()
         setupConstraints()
         mapView.delegate = self
         mapView.userLocation.title = Resources.Strings.userLocationTitle
         startTimer()
     }

     func createHeartForDisplay() {
         
         if heartCount == 1 {
                     let heartView = LottieAnimationView(name: "heartFull")
                         heartView.play()
                         heartViews.append(heartView)
             
         } else if heartCount == 2 {
                     let heartView = LottieAnimationView(name: "heartFull")
                         heartView.play()
                         heartViews.append(heartView)
             
                     let heartView1 = LottieAnimationView(name: "heartFull")
                     heartView1.play()
                     heartViews.append(heartView1)
         } else if heartCount == 3 {
                     let heartView = LottieAnimationView(name: "heartFull")
                         heartView.play()
                         heartViews.append(heartView)
             
                     let heartView1 = LottieAnimationView(name: "heartFull")
                     heartView1.play()
                     heartViews.append(heartView1)
             
                     let heartView2 = LottieAnimationView(name: "heartFull")
                     heartView2.play()
                     heartViews.append(heartView2)
         } else {
             
         }
         
     }
     
     
     
     private func startTimer() {
         timer = Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { [weak self] _ in
                 self?.updateAnnotations()
             }
         }
     
     private func updateAnnotations() {
             let shouldRemoveMonster = { return Int.random(in: 1...5) == 1 } // 20% вероятность исчезновения монстра с карты
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
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         checkLocationAuthorization()

         updateHeartViewConstraints()
         
     }
     

     func didCaptureMonster(_ monster: Monster) {
         capturedMonsters.append(monster)
             let annotations = mapView.annotations.filter { $0.coordinate.latitude == monster.latitude && $0.coordinate.longitude == monster.longitude }
             mapView.removeAnnotations(annotations)
     }
     func didEscapeMonster(_ monster: Monster) {
         escapedMonsters.append(monster)
             let annotations = mapView.annotations.filter { $0.coordinate.latitude == monster.latitude && $0.coordinate.longitude == monster.longitude }
             mapView.removeAnnotations(annotations)
     }
     
     func updateHeart() {
         if !heartViews.isEmpty {
             let heartView = heartViews.removeLast()
             heartView.removeFromSuperview()
             heartCount -= 1
             UserDefaults.standard.set(heartCount, forKey: "heartCount")
         }
     }
     
     func buttonStyle() {
         myTeamButton.MyOwnButtonStile(setTitle: Resources.Strings.myTeamButtonTitle, fontSize: 18)
         locationButton.stileForLocationButton()
         
         questionButton.setTitleColor(.systemBlue, for: .normal)
         questionButton.layer.shadowColor = UIColor.black.cgColor
         questionButton.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
         questionButton.layer.shadowRadius = 8
         questionButton.layer.shadowOpacity = 0.5
         questionButton.clipsToBounds = true
         questionButton.layer.masksToBounds = false

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
     
     func deliteHeart() {
                 if !heartViews.isEmpty {
                         let lastHeartView = heartViews.removeLast()
                         lastHeartView.removeFromSuperview()
                     
                     heartCount -= 1
                     UserDefaults.standard.set(heartCount, forKey: "heartCount")

                     }
         
     }
     
     func addHeart() {
         let newHeartView = LottieAnimationView(name: "heartFull")
            newHeartView.play()
            
            let lastHeartView = heartViews.last ?? UIView()
            let x = lastHeartView.frame.origin.x + lastHeartView.frame.size.width + 30
            let y = lastHeartView.frame.origin.y
            newHeartView.frame = CGRect(x: x, y: y, width: 50, height: 50)
            
            heartViews.append(newHeartView)
            view.addSubview(newHeartView)
         
         heartCount += 1
         UserDefaults.standard.set(heartCount, forKey: "heartCount")

        updateHeartViewConstraints()

     }
     
     func updateHeartViewConstraints() {
         for heartView in heartViews {
             heartView.removeFromSuperview()
         }
         
         for i in 0..<heartCount {
             if i < heartViews.count {
                 let heartView = heartViews[i]
                 view.addSubview(heartView)
                 
                 heartView.translatesAutoresizingMaskIntoConstraints = false
                 NSLayoutConstraint.activate([
                 heartView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
                 heartView.widthAnchor.constraint(equalToConstant: 50),
                 heartView.heightAnchor.constraint(equalToConstant: 50)
                 ])
                 if i == 0 {
                     NSLayoutConstraint.activate([
                         heartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
                     ])
                 } else {
                     let previousHeartView = heartViews[i - 1]
                     NSLayoutConstraint.activate([
                         heartView.leadingAnchor.constraint(equalTo: previousHeartView.trailingAnchor, constant: -30)
                     ])
                 }
             } else {

                 let newHeartView = LottieAnimationView(name: "heartFull")
                 newHeartView.play()
                 
                 let lastHeartView = heartViews.last ?? UIView()
                 let x = lastHeartView.frame.origin.x + lastHeartView.frame.size.width + 30
                 let y = lastHeartView.frame.origin.y
                 newHeartView.frame = CGRect(x: x, y: y, width: 50, height: 50)
                 heartViews.append(newHeartView)
                 view.addSubview(newHeartView)
             }
         }
     }

     
     
     @objc func buttonTapped() {
         let myTeamVC = MyTeamViewController()
             myTeamVC.capturedMonsters = capturedMonsters
         navigationController?.pushViewController(myTeamVC, animated: true)
         capturedMonsters.forEach { monster in
             print("\(monster.name), \(monster.subtitle)")
         }
     }
     
     func updateUserLocation(to location: CLLocation, with title: String) {
         let point = MKPointAnnotation()
         point.title = title
         point.coordinate = location.coordinate
         let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
         self.mapView.setRegion(region, animated: true)
     }
     

     func centerViewOnUserLocation() {
         if let location = locationManager.location?.coordinate {
             let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
             mapView.setRegion(region, animated: true)
         }
     }

     private func setupViews() {
         view.addSubview(mapView)
         
         view.addSubview(questionButton)
         view.addSubview(locationButton)
         view.addSubview(myTeamButton)
         view.addSubview(zoomInButton)
         view.addSubview(zoomOutButton)

         for heartView in heartViews {
             view.addSubview(heartView)
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

    private func createMonster(title: String,subtitle: String, lat: Double, long: Double) -> MKPointAnnotation {
         let monster = MKPointAnnotation()
         monster.title = title
         monster.subtitle = subtitle
         monster.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
         return monster
     }
  
       func addHeartAnnotations() {
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
             annotationView.image = heartView
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
                     let lavelRandom = Int.random(in: 1...10)

                     let randomLatitude = currentLocation.coordinate.latitude + latitudeOffset
                     let randomLongitude = currentLocation.coordinate.longitude + longitudeOffset

                     let randomMonster = monsters.randomElement()!
                     let monster = Monster(name: randomMonster.name, subtitle: randomMonster.subtitle + String(lavelRandom), imageName: randomMonster.imageName, latitude: randomLatitude, longitude: randomLongitude, backgraund: randomMonster.backgraund)
                     let monsterAnnotation = MonsterAnnotation(monster: monster)
                     mapView.addAnnotation(monsterAnnotation)

                 }

             } else {

             }
     }

 }
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
 
       }
    
 }
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
                 //MARK: расстояние
                 if distance <= 600 {
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

 struct Monster: Equatable,Encodable,Decodable {
     let name: String
     let subtitle: String
     let imageName: String
     var latitude: Double
     var longitude: Double
     let backgraund: String
 }

 final class MonsterAnnotation: MKPointAnnotation {
     let monster: Monster

     init(monster: Monster) {
         self.monster = monster
         super.init()
         self.title = monster.name
         self.subtitle = monster.subtitle
         self.coordinate = CLLocationCoordinate2D(latitude: monster.latitude, longitude: monster.longitude)
     }
 }


 var monsters = [
     Monster(name: Resources.MonsterName.godzilla, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.godzilla, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.godzilla),
     Monster(name: Resources.MonsterName.ghost, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.ghost, latitude: 59.93358487887655, longitude: 30.35071790935886, backgraund: Resources.MonsterBackgraund.ghost),
     Monster(name: Resources.MonsterName.slept, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.slept, latitude: 59.931509638232065, longitude: 30.358925674068285, backgraund: Resources.MonsterBackgraund.slept)
 ]


*/

