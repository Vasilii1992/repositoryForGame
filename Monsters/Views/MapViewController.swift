

import UIKit
import MapKit
import CoreLocation
import Lottie


class MapViewController: UIViewController,MonsterCaptureDelegate{

    

    private var appId = "6472716706"
    
    var heartViews = [LottieAnimationView]()
    var heartCount = 3
        
    let heartView = UIImage(named: "heart")
    
    var mapView = MKMapView()
    var capturedMonsters: [Monster] = [] {
        didSet {
            myTeamViewController?.capturedMonsters = capturedMonsters
            myTeamViewController?.tableView.reloadData()
            //сохраняю данные в UserDefaults
            let userDefaults = UserDefaults.standard
            let encodedData = try? JSONEncoder().encode(capturedMonsters)
            userDefaults.set(encodedData, forKey: "capturedMonsters")
        }
    }
    
    var escapedMonsters: [Monster] = []

    weak var myTeamViewController: MyTeamViewController?
    weak var catchViewContriller: CatchViewController?   //
    private var currentCoordinate: CLLocationCoordinate2D?
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
        
        // Load heartCount from UserDefaults
        if let savedHeartCount = UserDefaults.standard.value(forKey: "heartCount") as? Int {
            heartCount = savedHeartCount
        }

        // получаю данные из UserDefaults
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
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
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
 // удаляем с карты монстра
            let annotations = mapView.annotations.filter { $0.coordinate.latitude == monster.latitude && $0.coordinate.longitude == monster.longitude }
            mapView.removeAnnotations(annotations)
    }
    func didEscapeMonster(_ monster: Monster) {
        escapedMonsters.append(monster)
 // удаляем сбежавшего с карты монстра
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
        
       // questionButton.stileForQuestionButton()

                questionButton.setTitleColor(.systemBlue, for: .normal)
                
                questionButton.layer.shadowColor = UIColor.black.cgColor
                questionButton.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
                questionButton.layer.shadowRadius = 8
                questionButton.layer.shadowOpacity = 0.5
                questionButton.clipsToBounds = true
                questionButton.layer.masksToBounds = false
// если isUserInteractionEnabled равно false то ивент нажатия на эту вью игнарируется и убирается из очереди
        questionMark.isUserInteractionEnabled = false
        questionMark.animationSpeed = 0.5
        questionMark.loopMode = .loop
        questionMark.play()
        questionButton.addSubview(questionMark)
        
        questionMark.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        


        animationPoint.isUserInteractionEnabled = true
        animationPoint.animationSpeed = 0.5 // сделать медленее

        animationPoint.loopMode = .loop
        animationPoint.play()
        

        
        
        heartViewAnimate.isUserInteractionEnabled = true
        heartViewAnimate.animationSpeed = 0.5 // сделать медленее

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
           
           // Add the new heart view to the view hierarchy and the heartViews array
           heartViews.append(newHeartView)
           view.addSubview(newHeartView)
        
        heartCount += 1
        UserDefaults.standard.set(heartCount, forKey: "heartCount")


        
       updateHeartViewConstraints()

    }
    
    func updateHeartViewConstraints() {
        // Remove existing heartViews from the view hierarchy
        for heartView in heartViews {
            heartView.removeFromSuperview()
        }
        
        // Add heartViews based on heartCount
        for i in 0..<heartCount {
            if i < heartViews.count { // check if index is within bounds of array
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
                // Add new heart views if heartCount is greater than the number of heart views in the array
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
        // обнавляю массив в MyTeamViewController
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
    

// функция приближения карты
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

    // Функция создания монстра
   private func createMonster(title: String,subtitle: String, lat: Double, long: Double) -> MKPointAnnotation {
        let monster = MKPointAnnotation()
        monster.title = title
        monster.subtitle = subtitle
        monster.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        return monster
    }
 
    private func addHeartAnnotations() {
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


// Добавление монстра на карту
    private func addAnnotation(with count: Int) {
        if let currentLocation = locationManager.location {
                let region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
                mapView.setRegion(region, animated: true)

                for _ in 1...count {
                    let latitudeOffset = Double.random(in: -0.0089...0.0089)
                    let longitudeOffset = Double.random(in: -0.0089...0.0089)
                    let lavelRandom = Int.random(in: 1...60)

                    let randomLatitude = currentLocation.coordinate.latitude + latitudeOffset
                    let randomLongitude = currentLocation.coordinate.longitude + longitudeOffset

                    let randomMonster = monsters.randomElement()!
                    let monster = Monster(name: randomMonster.name, subtitle: randomMonster.subtitle + String(lavelRandom), imageName: randomMonster.imageName, latitude: randomLatitude, longitude: randomLongitude, backgraund: randomMonster.backgraund)
                    let monsterAnnotation = MonsterAnnotation(monster: monster)
                    mapView.addAnnotation(monsterAnnotation)

                }

            } else {
                // если юзер локатион нил
            }
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
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: Resources.Identifiers.identifierForAnnotation)
        }
        
        if let monster = monsters.first(where: { $0.name == title }) {
            annotationView?.image = UIImage(named: monster.imageName)
            // размер картинки
            annotationView?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            
        } else if annotation === mapView.userLocation {
            // анимация нашей геолакации
            //добавил картинку персонажа,но не думаю что нужно
            annotationView?.image = UIImage(named: "Hero2")
            annotationView?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            annotationView?.addSubview(animationPoint)
            animationPoint.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            // добавил прозрачность
            // animationPoint.layer.opacity = 0.2
            
            // этот код ставит картинку поверх анимации
            let heroImageView = UIImageView(image: UIImage(named: "Hero2"))
            heroImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            annotationView?.addSubview(heroImageView)
            
            animationPoint.center = CGPoint(x: annotationView!.bounds.size.width / 2, y: annotationView!.bounds.size.height / 2)
        } else if
            title == "Heart" {
            annotationView?.image = heartView
            annotationView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            
            // так можно добавить экшн на аннотацию, но я сделал через didSelect
            //            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(heartViewTapped(_:)))
            //                       annotationView?.addGestureRecognizer(tapGestureRecognizer)
        }
        
        annotationView?.canShowCallout = true
        
        return annotationView
        
        
    }
    
    //    @objc private func heartViewTapped(_ gestureRecognizer: UITapGestureRecognizer) {
    //        if !heartViews.isEmpty {
    //            let lastHeartView = heartViews.removeLast()
    //            lastHeartView.removeFromSuperview()
    //        }
    //    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        if heartViews.isEmpty {
//            notCaughtLabel.createNewLabel(text: "вы не можете поймать монстра", color: color, size: 20)
//            notCaughtLabel.text = "вы не можете поймать монстра"
//            notCaughtLabel.center = self.view.center
//            notCaughtLabel.frame.origin.y += 80
//            notCaughtLabel.alpha = 0.0
//            let fixedWidth: CGFloat = 250
//            let size = CGSize(width: fixedWidth, height: .infinity)
//            let estimatedSize = notCaughtLabel.sizeThatFits(size)
//            notCaughtLabel.frame = CGRect(x: 70, y: 400, width: fixedWidth, height: estimatedSize.height)
//            self.view.addSubview(notCaughtLabel)
//            UIView.animate(withDuration: 1.0, animations: {
//                self.notCaughtLabel.alpha = 1.0
//            }) { _ in
//                UIView.animate(withDuration: 3.0, animations: {
//                    self.notCaughtLabel.alpha = 0.0
//                }) { _ in
//                    self.notCaughtLabel.removeFromSuperview()
//                }
//            }
//        }
        //        guard let monsterAnnotation = view.annotation as? MonsterAnnotation else { return }
        if let title = view.annotation?.title, title == "Heart", let userLocation = mapView.userLocation.location {
            let heartLocation = CLLocation(latitude: view.annotation!.coordinate.latitude, longitude: view.annotation!.coordinate.longitude)
            let distance = userLocation.distance(from: heartLocation)
            if distance <= 100 {
                addHeart()
                // удаление с карты сердца 
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
            
            
            // логика расстояния
            if let userLocation = mapView.userLocation.location {
                let monsterLocation = CLLocation(latitude: monsterAnnotation.coordinate.latitude, longitude: monsterAnnotation.coordinate.longitude)
                let distance = userLocation.distance(from: monsterLocation)
                
                if distance <= 100 {
                    let newVC = CatchViewController(monster: monsterAnnotation.monster, heartViews: heartViews)
                    newVC.delegate = self
                    newVC.monster = monsterAnnotation.monster
                    newVC.caughtLabel.text = "\(monsterAnnotation.monster.name)" + Resources.Strings.caught
                    // сделал так чтобы размер одоптировался под длинну текста
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


/*
 
 imagine that you are an iOS Developer.
 Task: there are two view controllers, using the "returnToMapButtonTapped" method, we return to another view controller. You need to make a custom transition from one controller to another.
 use this code to solve the problem:

 import UIKit


 class QuestionViewController: UIViewController {
     

     let label: UILabel = {

         let label = UILabel(frame: CGRect(x: 10, y: 100, width: 300, height: 100))

         label.createNewLabel(text: "В этой игре вам необходимо ловить монстров", color: color, size: 20)
         
         return label
     }()
     
     let nextButton: UIButton = {
         let button = UIButton(frame: CGRect(x: 150, y: 750, width: 100, height: 50))
         button.MyOwnButtonStile(setTitle: "Далее", fontSize: 20)
         
         return button
     }()
     
     let instructionLabel: UILabel = {

         let label = UILabel(frame: CGRect(x: 90, y: 180, width: 300, height: 100))
         label.createNewLabel(text: "Если вы находитесь в радиусе 100 метров от монстра, вы можете попробовать его поймать", color: color, size: 20)
         label.isHidden = true
         
         return label
     }()
     
     let instructionLabel2: UILabel = {

         let label = UILabel(frame: CGRect(x: 10, y: 300, width: 300, height: 100))

         label.createNewLabel(text: "Монстер имеет возможность Убежать или Ударить вас.", color: color, size: 20)
         label.isHidden = true
         
         return label
     }()
     
     let instructionLabel3: UILabel = {

         let label = UILabel(frame: CGRect(x: 90, y: 370, width: 300, height: 100))

         label.createNewLabel(text: "Если монстр вас ударил,то вы теряете одно сердце.Если у вас нет сердец,вы не можете поймать монстра.", color: color, size: 20)
         label.isHidden = true
         
         return label
     }()
     
     let instructionLabel4: UILabel = {

         let label = UILabel(frame: CGRect(x: 10, y: 510, width: 300, height: 100))

         label.createNewLabel(text: "Дополнительные сердца так же можно найти на карте,собирайте их,чтобы увеличить шанс поимки монстра", color: color, size: 20)
         label.isHidden = true
         
         return label
     }()
     
     let instructionLabel5: UILabel = {

         let label = UILabel()
         label.createNewLabel(text: "Соберите свою коллекцию монстров.\nУдачи!", color: color, size: 20)
         label.isHidden = true
         
         return label
     }()
     
     var nextButtonTapCount = 0
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         
         let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
         backgroundImage.image = UIImage(named: "questionBackgraund2")
         backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
         view.addSubview(backgroundImage)
         
         view.backgroundColor = .white
         view.addSubview(label)
         view.addSubview(nextButton)
         view.addSubview(instructionLabel)
         view.addSubview(instructionLabel2)
         view.addSubview(instructionLabel3)
         view.addSubview(instructionLabel4)
         view.addSubview(instructionLabel5)
         
         setupConstrains()
         addButtonAction()
     }
     
     func addButtonAction() {
         nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
     }
     func setupConstrains() {
         instructionLabel5.translatesAutoresizingMaskIntoConstraints = false
         instructionLabel5.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
         instructionLabel5.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
     }
     
     @objc func returnToMapButtonTapped() {
         self.navigationController?.popViewController(animated: true)
     }
     
     @objc func nextButtonTapped() {
         nextButtonTapCount += 1
         
         if nextButtonTapCount == 1 {
             UIView.animate(withDuration: 1.0, animations: {
                 self.label.alpha = 0
             })
             instructionLabel.isHidden = false
         } else if nextButtonTapCount == 2 {
             UIView.animate(withDuration: 1.0, animations: {
                 self.instructionLabel.alpha = 0
             })
             instructionLabel2.isHidden = false
         } else if nextButtonTapCount == 3 {
             UIView.animate(withDuration: 1.0, animations: {
                 self.instructionLabel2.alpha = 0
             })
             instructionLabel3.isHidden = false
         } else if nextButtonTapCount == 4 {
             UIView.animate(withDuration: 1.0, animations: {
                 self.instructionLabel3.alpha = 0
             })
             instructionLabel4.isHidden = false
         } else if nextButtonTapCount == 5 {
             UIView.animate(withDuration: 1.0, animations: {
                 self.instructionLabel4.alpha = 0
             })
             instructionLabel5.isHidden = false
             self.nextButton.setTitle("Назад", for: .normal)
                             self.nextButton.removeTarget(self, action: #selector(self.nextButtonTapped), for: .touchUpInside)
                             self.nextButton.addTarget(self, action: #selector(self.returnToMapButtonTapped), for: .touchUpInside)
         } else {
            
         }
         
     }
     
     
     
 }

 
 
 */
