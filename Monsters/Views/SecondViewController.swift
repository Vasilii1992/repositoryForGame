

import Foundation
import UIKit
import CoreLocation
import Lottie
class SecondViewController: UIViewController {
    
    let animation = LottieAnimationView(name: "permission")

    override func viewDidLoad() {
        super.viewDidLoad()
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "backForSecondVC")
//        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
//        view.addSubview(backgroundImage)
        
        view.backgroundColor = .white
        
        animation.frame = view.bounds
        animation.loopMode = .loop
        animation.play()
        view.addSubview(animation)
        let alert = UIAlertController(title: Resources.SecondVC.warning, message: Resources.SecondVC.warningMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)

    }
}



