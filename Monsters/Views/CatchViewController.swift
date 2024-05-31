

import Foundation
import UIKit
import MapKit
import CoreGraphics
import Lottie

final class CatchViewController: UIViewController {

    weak var delegate: MonsterCaptureDelegate?
    var monster: Monster
    var heartViews: [LottieAnimationView]
    let imageView = UIImageView()
    var monsterImage: UIImage?
    let catchButton = UIButton()
    let color2 = #colorLiteral(red: 0.1607843041, green: 0.1607843041, blue: 0.1607843041, alpha: 1)
    let color = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    let monsterNameLabel = UILabel()
    let notCaughtLabel = UILabel()
    let imageViewForAnimation = LottieAnimationView(name: "stars")
    let runAnimation = LottieAnimationView(name: "running-animation")


    
    let caughtLabel: UILabel = {
       let label = UILabel()
        let color = #colorLiteral(red: 0.9386829734, green: 0.3526317179, blue: 0.4194241762, alpha: 1)
        label.text = "Монстер Пойман!"
        label.font = UIFont(name: "Marker Felt", size: 35)
        label.textColor = color
        label.sizeToFit()
        return label
    }()

    init(monster: Monster, heartViews: [LottieAnimationView]) {
           self.monster = monster
           self.heartViews = heartViews
           super.init(nibName: nil, bundle: nil)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        addActionToButton()
        imageViewForAnimation.alpha = 0.0
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: monster.backgraund)
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        view.addSubview(backgroundImage)
        buttonStile()
        setupImageView()
        setupConstraints()
        
        heartConstrains()
    }
    
    func heartConstrains() {
        for (index, heartView) in heartViews.enumerated() {
            heartView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(heartView)
            NSLayoutConstraint.activate([
                heartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                heartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: CGFloat(index * 20)),
                heartView.widthAnchor.constraint(equalToConstant: 50),
                heartView.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    }
    
    func buttonStile() {
        catchButton.MyOwnButtonStile(setTitle: Resources.Strings.catchButtonTitle, fontSize: 18)
    }
    func addActionToButton() {
        catchButton.addTarget(self, action: #selector(buttonTappedForCatch), for: .touchUpInside)
    }

    @objc func buttonTappedForCatch() {

        let array = [1, 2, 3, 4]
        let arrayForEscaping = [1,2,3,4]
        let randomIndex = Int.random(in: 0..<array.count)
        let randomIndexEscape = Int.random(in: 1..<arrayForEscaping.count)
        
        if heartViews.isEmpty {
            notCaughtLabel.createNewLabel(text: Resources.Strings.noLives, color: color, size: 20)
            notCaughtLabel.center = self.imageView.center
            notCaughtLabel.frame.origin.y += 160
            notCaughtLabel.alpha = 0.0
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
            
        } else if array[randomIndex] == 4 {
            self.monsterNameLabel.alpha = 0.0
            let originalFrame = imageView.frame
            let finalFrame = CGRect(x: imageView.frame.origin.x + imageView.frame.width / 2.0,
                                    y: imageView.frame.origin.y + imageView.frame.height / 2.0,
                                    width: 0,
                                    height: 0)
            
            imageView.contentMode = .scaleAspectFill
            UIView.animate(withDuration: 2.0, animations: {
                self.imageViewForAnimation.alpha = 1.0
            }) { _ in
                UIView.animate(withDuration: 2.0, animations: {
                    self.imageViewForAnimation.alpha = 0.0
                }) { _ in
                    self.imageViewForAnimation.removeFromSuperview()
                }
            }
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut], animations: {

                self.imageView.frame = finalFrame
                self.imageView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }, completion: { _ in
                self.imageView.transform = .identity
                self.imageView.frame = originalFrame
                self.imageView.addSubview(self.imageViewForAnimation)
                self.imageViewForAnimation.play()
                UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut], animations: {
                    self.imageView.contentMode = .scaleAspectFit
                }, completion: { _ in
                    self.caughtLabel.center = self.imageView.center
                    self.caughtLabel.frame.origin.y -= 60
                    self.caughtLabel.frame.origin.x += 15
                    self.caughtLabel.alpha = 0.0
                    self.view.addSubview(self.caughtLabel)
                    
                    UIView.animate(withDuration: 1.0, animations: {
                        self.caughtLabel.alpha = 1.0
                    }) { _ in
                        UIView.animate(withDuration: 3.0, animations: {
                            self.caughtLabel.alpha = 0.0
                            self.imageView.alpha = 0.0
                        }) { _ in
                            self.caughtLabel.removeFromSuperview()
                        }
                    }
                })
                self.delegate?.didCaptureMonster(self.monster)
                self.catchButton.setTitle(Resources.Strings.backToMap, for: .normal)
                                self.catchButton.removeTarget(self, action: #selector(self.buttonTappedForCatch), for: .touchUpInside)
                                self.catchButton.addTarget(self, action: #selector(self.returnToMapButtonTapped), for: .touchUpInside)
                            
            })
            
            NSLayoutConstraint.activate([
                
                imageView.widthAnchor.constraint(equalToConstant: 100),
                imageView.heightAnchor.constraint(equalToConstant: 100),
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        } else if arrayForEscaping[randomIndexEscape] == 3 {
            let color = #colorLiteral(red: 0.4411078095, green: 0.7488664389, blue: 0.9981990457, alpha: 1)
            self.monsterNameLabel.alpha = 0.0
            let caughtImage = UIImage(named: "escape")
            
            let originalFrame = imageView.frame
            let finalFrame = CGRect(x: imageView.frame.origin.x + imageView.frame.width / 2.0,
                                    y: imageView.frame.origin.y + imageView.frame.height / 2.0,
                                    width: 0,
                                    height: 0)
            
            imageView.contentMode = .scaleAspectFill
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut], animations: {
                self.imageView.frame = finalFrame
                self.imageView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }, completion: { _ in
                self.imageView.transform = .identity
                self.imageView.frame = originalFrame
                
                self.imageView.image = caughtImage
                
                UIView.animate(withDuration: 1, delay: 0.0, options: [.curveEaseInOut], animations: {
                    self.imageView.contentMode = .scaleAspectFit
                }, completion: { _ in
                    self.caughtLabel.center = self.imageView.center
                    self.caughtLabel.frame.origin.y -= 60
                    self.caughtLabel.alpha = 0.0
                    self.caughtLabel.text = Resources.Strings.monsterEscaped
                    self.caughtLabel.textColor = color
                    self.caughtLabel.sizeToFit()
                    self.view.addSubview(self.caughtLabel)
                    
                    UIView.animate(withDuration: 1.0, animations: {
                        self.caughtLabel.alpha = 1.0
                    }) { _ in
                        UIView.animate(withDuration: 3.0, animations: {
                            self.caughtLabel.alpha = 0.0
                            self.imageView.alpha = 0.0
                        }) { _ in
                            self.caughtLabel.removeFromSuperview()
                        }
                    }
                })
                self.delegate?.didEscapeMonster(self.monster)
                self.catchButton.setTitle(Resources.Strings.backToMap, for: .normal)
                                self.catchButton.removeTarget(self, action: #selector(self.buttonTappedForCatch), for: .touchUpInside)
                                self.catchButton.addTarget(self, action: #selector(self.returnToMapButtonTapped), for: .touchUpInside)
            })
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 100),
                imageView.heightAnchor.constraint(equalToConstant: 100),
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
        else {
            notCaughtLabel.createNewLabel(text: Resources.Strings.monsterStruck, color: color, size: 20)
            notCaughtLabel.center = self.imageView.center
            notCaughtLabel.frame.origin.y += 160
            notCaughtLabel.alpha = 0.0
            self.view.addSubview(notCaughtLabel)
            if !heartViews.isEmpty {
                let heartView = heartViews.removeLast()
                heartView.removeFromSuperview()
            }
            delegate?.updateHeart()

            
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

    @objc func returnToMapButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    private func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.image = monsterImage
        monsterNameLabel.createNewLabel(text: "\(monster.name)\n\(monster.subtitle)", color: color, size: 16)
        monsterNameLabel.sizeToFit()
    }

    private func setupConstraints() {
        view.addSubview(monsterNameLabel)
        view.addSubview(imageView)
        view.addSubview(imageViewForAnimation)
        view.addSubview(catchButton)

        catchButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        monsterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        imageViewForAnimation.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 120),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            
            imageViewForAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageViewForAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -120),
            imageViewForAnimation.widthAnchor.constraint(equalToConstant: 200),
            imageViewForAnimation.heightAnchor.constraint(equalToConstant: 200),
            
            catchButton.heightAnchor.constraint(equalToConstant: 48),
            catchButton.widthAnchor.constraint(equalToConstant: 344),
            catchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            catchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -15),
            
            monsterNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 70),
            monsterNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -20),
            monsterNameLabel.widthAnchor.constraint(equalToConstant: 100),
            monsterNameLabel.heightAnchor.constraint(equalToConstant: 50),
   
        ])
    }
}
