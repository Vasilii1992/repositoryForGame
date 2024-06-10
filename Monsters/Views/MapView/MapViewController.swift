

import UIKit
import MapKit
import CoreLocation
import Lottie


final class MapViewController: UIViewController,MonsterCaptureDelegate {

    var heartManager: HeartManager!
    var annotationManager: MapAnnotationManager!
    var heartCount = 3
    
    let heartView = UIImage(named: Resources.ImageForDisplay.heart)
    
    var mapView = MKMapView()
    var capturedMonsters: [Monster] = [] {
        didSet {
            myTeamViewController?.capturedMonsters = capturedMonsters
            myTeamViewController?.tableView.reloadData()
            let userDefaults = UserDefaults.standard
            let encodedData = try? JSONEncoder().encode(capturedMonsters)
            userDefaults.set(encodedData, forKey: Resources.KeyForUserDefaults.capturedMonsters)
        }
    }
    
    var escapedMonsters: [Monster] = []

    weak var myTeamViewController: MyTeamViewController?
    weak var catchViewContriller: CatchViewController?
     var currentCoordinate: CLLocationCoordinate2D?

    let zoomInButton = UIButton()
    let zoomOutButton = UIButton()
    let locationButton = UIButton()
    
    let questionButton = UIButton()
    
    let animationPoint: LottieAnimationView = {
        let animation = LottieAnimationView(name: Resources.LottieAnimationView.pointGreen)
        animation.contentMode = .scaleAspectFit
        return animation
    }()
    
    let questionMark: LottieAnimationView = {
        let animation = LottieAnimationView(name: Resources.LottieAnimationView.questionMark)
        animation.contentMode = .scaleAspectFit
        return animation
    }()
    let heartViewAnimate: LottieAnimationView = {
        let animation = LottieAnimationView(name: Resources.LottieAnimationView.heartPoint)
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
        
        userDefaults()

        heartManager = HeartManager.shared
        annotationManager = MapAnnotationManager(mapView: mapView, locationManager: locationManager, regionInMeters: regionInMeters)

        heartManager.updateHeartViewConstraints(in: view)
        
        addActionToButton()
        buttonStyle()
        checkLocationServices()
        setupViews()
        setupConstraints()
        mapView.delegate = self
        mapView.userLocation.title = Resources.Strings.userLocationTitle
        annotationManager.startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLocationAuthorization()

        heartManager.updateHeartViewConstraints(in: view)
        
    }
    
    func userDefaults() {
        
        if let savedHeartCount = UserDefaults.standard.value(forKey: Resources.KeyForUserDefaults.heartCount) as? Int {
            heartCount = savedHeartCount
        }

       
         let userDefaults = UserDefaults.standard
        if let savedData = userDefaults.object(forKey: Resources.KeyForUserDefaults.capturedMonsters) as? Data,
            let decodedData = try? JSONDecoder().decode([Monster].self, from: savedData) {
             capturedMonsters = decodedData
         }
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
        heartManager.updateHeart(in: view)
     }
    
    func deliteHeart() {
        heartManager.deleteHeart(in: view)
    }
    
    func addHeart() {
        heartManager.addHeart(in: view)
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
        
        for heartView in heartManager.heartViews {
            view.addSubview(heartView)
        }
    }

   private func createMonster(title: String,subtitle: String, lat: Double, long: Double) -> MKPointAnnotation {
        let monster = MKPointAnnotation()
        monster.title = title
        monster.subtitle = subtitle
        monster.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        return monster
    }
}
