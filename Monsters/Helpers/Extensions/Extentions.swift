

import Foundation
import UIKit
import Lottie

extension UIButton {
    
    func MyOwnButtonStile(setTitle: String, fontSize: CGFloat) {
        let color = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.setTitleColor(.white, for: .normal)
        self.setTitle(setTitle, for: .normal)
        
        self.backgroundColor = UIColor.systemGray.withAlphaComponent(0.4)
        
        self.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: fontSize)

        self.layer.cornerRadius = 25
        self.layer.borderWidth = 2.0
        self.layer.borderColor = color.cgColor
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.5
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    }
    
    
    func stileForLocationButton() {
        self.setImage(UIImage(named: "location2"), for: .normal)
        self.setTitleColor(.systemBlue, for: .normal)
        
        self.layer.shadowColor   = UIColor.black.cgColor
        self.layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
        self.layer.shadowRadius  = 8
        self.layer.shadowOpacity = 0.5
        self.clipsToBounds       = true
        self.layer.masksToBounds = false
        
    }
//    func stileForQuestionButton() {
//        self.setImage(UIImage(named: "question"), for: .normal)
//        self.setTitleColor(.systemBlue, for: .normal)
//
//        self.layer.shadowColor   = UIColor.black.cgColor
//        self.layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
//        self.layer.shadowRadius  = 8
//        self.layer.shadowOpacity = 0.5
//        self.clipsToBounds       = true
//        self.layer.masksToBounds = false
//
//    }
    func stileForQuestionButton() {
       // let animationView = LottieAnimationView(name: "question-mark")
      //  animationView.frame = bounds
      //  animationView.contentMode = .scaleAspectFit
       // animationView.loopMode = .loop
      //  animationView.play()
      //  addSubview(animationView)
        
        self.setTitleColor(.systemBlue, for: .normal)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.5
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    }
}


extension UILabel {
    
    func createNewLabel(text: String,color: UIColor,size: CGFloat) {
       
        self.text = text
        self.font = UIFont(name: "AvenirNext-DemiBold", size: size)
        self.textColor = .white.withAlphaComponent(0.7)
        self.numberOfLines = 0
        self.textAlignment = .center
        self.backgroundColor = color.withAlphaComponent(0.7)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.sizeToFit()
    }
    
}

extension String {
    func localized() -> String {
        NSLocalizedString(self,
                          tableName: "Localizable",
                          bundle: .main,
                          value: self,
                          comment: self)
    }
}
