

import UIKit
import MapKit
import CoreLocation
import Lottie


final class MapViewController: UIViewController,MonsterCaptureDelegate{

    private var appId = "6472716706"
    
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
