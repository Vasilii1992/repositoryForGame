

import Foundation
import UIKit
import CoreLocation
import Lottie

class FirstViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    let color = #colorLiteral(red: 0.9712495208, green: 0.9563626647, blue: 0.9220876098, alpha: 1)
    let animation = LottieAnimationView(name: Resources.LottieAnimationView.monsters)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        view.backgroundColor = color
        
        animation.frame = view.bounds
        animation.loopMode = .loop
        animation.play()
        view.addSubview(animation)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                self.showMapViewControllerWithDelay()
    }
    
    private func showMapViewControllerWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
            let mapViewController = MapViewController()
            let navigationController = UINavigationController(rootViewController: mapViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: false, completion: nil)
        }
    }
    
    private func showSecondViewControllerWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let secondViewController = SecondViewController()
            let navigationController = UINavigationController(rootViewController: secondViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: false, completion: nil)
        }
    }

}

extension FirstViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            showMapViewControllerWithDelay()
        case .denied:
            showSecondViewControllerWithDelay()
        default:
            break
        }
    }
}
