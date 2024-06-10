

import UIKit
import Lottie

class HeartManager {
    
    static let shared = HeartManager()

    var heartViews = [LottieAnimationView]()
    var heartCount: Int {
        didSet {
            UserDefaults.standard.set(heartCount, forKey: Resources.KeyForUserDefaults.heartCount)
        }
    }
    
    private init() {
        heartCount = UserDefaults.standard.integer(forKey: Resources.KeyForUserDefaults.heartCount)
        createHeartForDisplay()
    }
    
    func createHeartForDisplay() {
        for _ in 0..<heartCount {
            let heartView = LottieAnimationView(name: Resources.ImageForDisplay.heartFull)
            heartView.play()
            heartViews.append(heartView)
        }
    }
    
    func updateHeartViewConstraints(in view: UIView) {
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
                let newHeartView = LottieAnimationView(name: Resources.ImageForDisplay.heartFull)
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
    
    func updateHeart(in view: UIView) {
           if !heartViews.isEmpty {
               let heartView = heartViews.removeLast()
               heartView.removeFromSuperview()
               heartCount -= 1
               UserDefaults.standard.set(heartCount, forKey: Resources.KeyForUserDefaults.heartCount)
           }
       }
       
       func deleteHeart(in view: UIView) {
           if !heartViews.isEmpty {
               let lastHeartView = heartViews.removeLast()
               lastHeartView.removeFromSuperview()
               heartCount -= 1
               UserDefaults.standard.set(heartCount, forKey: Resources.KeyForUserDefaults.heartCount)
           }
       }
       
       func addHeart(in view: UIView) {
           let newHeartView = LottieAnimationView(name: Resources.ImageForDisplay.heartFull)
           newHeartView.play()
           
           let lastHeartView = heartViews.last ?? UIView()
           let x = lastHeartView.frame.origin.x + lastHeartView.frame.size.width + 30
           let y = lastHeartView.frame.origin.y
           newHeartView.frame = CGRect(x: x, y: y, width: 50, height: 50)
           
           heartViews.append(newHeartView)
           view.addSubview(newHeartView)
           
           heartCount += 1
           UserDefaults.standard.set(heartCount, forKey: Resources.KeyForUserDefaults.heartCount)
           
           updateHeartViewConstraints(in: view)
       }
}
