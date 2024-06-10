
import UIKit
import Lottie

protocol CatchManagerDelegate: AnyObject {
    func updateHeartViews(_ heartViews: [LottieAnimationView])
    func showCaughtLabel(_ label: UILabel)
    func showNotCaughtLabel(_ label: UILabel)
    func animateImageView(_ imageView: UIImageView, with animationView: LottieAnimationView)
    func didCaptureMonster(_ monster: Monster)
    func didEscapeMonster(_ monster: Monster)
}

class CatchManager {
    weak var delegate: CatchManagerDelegate?
    private var heartViews: [LottieAnimationView]
    private var monster: Monster

    init(monster: Monster, heartViews: [LottieAnimationView]) {
        self.monster = monster
        self.heartViews = heartViews
    }

    func buttonTappedForCatch(imageView: UIImageView, monsterNameLabel: UILabel, caughtLabel: UILabel, notCaughtLabel: UILabel, animationView: LottieAnimationView) {
        let array = [1, 2, 3, 4]
        let arrayForEscaping = [1, 2, 3, 4]
        let randomIndex = Int.random(in: 0..<array.count)
        let randomIndexEscape = Int.random(in: 1..<arrayForEscaping.count)

        if heartViews.isEmpty {
            showLabel(notCaughtLabel, withText: Resources.Strings.noLives, centeredIn: imageView)
        } else if array[randomIndex] == 4 {
            handleMonsterCaught(imageView: imageView, monsterNameLabel: monsterNameLabel, caughtLabel: caughtLabel, animationView: animationView)
        } else if arrayForEscaping[randomIndexEscape] == 3 {
            handleMonsterEscaped(imageView: imageView, monsterNameLabel: monsterNameLabel, caughtLabel: caughtLabel)
        } else {
            handleMonsterStruck(notCaughtLabel: notCaughtLabel, imageView: imageView)
        }
    }

    private func showLabel(_ label: UILabel, withText text: String, centeredIn imageView: UIImageView) {
        label.createNewLabel(text: text, color: UIColor.blue, size: 20) // Customize the color as needed
        label.center = imageView.center
        label.frame.origin.y += 160
        label.alpha = 0.0
        delegate?.showNotCaughtLabel(label)
    }

    private func handleMonsterCaught(imageView: UIImageView, monsterNameLabel: UILabel, caughtLabel: UILabel, animationView: LottieAnimationView) {
        monsterNameLabel.alpha = 0.0
        let originalFrame = imageView.frame
        let finalFrame = CGRect(x: imageView.frame.origin.x + imageView.frame.width / 2.0,
                                y: imageView.frame.origin.y + imageView.frame.height / 2.0,
                                width: 0,
                                height: 0)

        imageView.contentMode = .scaleAspectFill
        delegate?.animateImageView(imageView, with: animationView)

        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut], animations: {
            imageView.frame = finalFrame
            imageView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }, completion: { _ in
            imageView.transform = .identity
            imageView.frame = originalFrame
            imageView.addSubview(animationView)
            animationView.play()
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut], animations: {
                imageView.contentMode = .scaleAspectFit
            }, completion: { _ in
                caughtLabel.center = imageView.center
                caughtLabel.frame.origin.y -= 60
                caughtLabel.frame.origin.x += 15
                caughtLabel.alpha = 0.0
                self.delegate?.showCaughtLabel(caughtLabel)
            })
            self.delegate?.didCaptureMonster(self.monster)
        })

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.centerXAnchor.constraint(equalTo: imageView.superview!.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageView.superview!.centerYAnchor)
        ])
    }

    private func handleMonsterEscaped(imageView: UIImageView, monsterNameLabel: UILabel, caughtLabel: UILabel) {
        let color = UIColor(red: 0.441, green: 0.748, blue: 0.998, alpha: 1)
        monsterNameLabel.alpha = 0.0
        let caughtImage = UIImage(named: "escape")

        let originalFrame = imageView.frame
        let finalFrame = CGRect(x: imageView.frame.origin.x + imageView.frame.width / 2.0,
                                y: imageView.frame.origin.y + imageView.frame.height / 2.0,
                                width: 0,
                                height: 0)

        imageView.contentMode = .scaleAspectFill
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut], animations: {
            imageView.frame = finalFrame
            imageView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }, completion: { _ in
            imageView.transform = .identity
            imageView.frame = originalFrame

            imageView.image = caughtImage

            UIView.animate(withDuration: 1, delay: 0.0, options: [.curveEaseInOut], animations: {
                imageView.contentMode = .scaleAspectFit
            }, completion: { _ in
                caughtLabel.center = imageView.center
                caughtLabel.frame.origin.y -= 60
                caughtLabel.alpha = 0.0
                caughtLabel.text = Resources.Strings.monsterEscaped
                caughtLabel.textColor = color
                caughtLabel.sizeToFit()
                self.delegate?.showCaughtLabel(caughtLabel)
            })
            self.delegate?.didEscapeMonster(self.monster)
        })

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.centerXAnchor.constraint(equalTo: imageView.superview!.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageView.superview!.centerYAnchor)
        ])
    }

    private func handleMonsterStruck(notCaughtLabel: UILabel, imageView: UIImageView) {
        showLabel(notCaughtLabel, withText: Resources.Strings.monsterStruck, centeredIn: imageView)
        if !heartViews.isEmpty {
            let heartView = heartViews.removeLast()
            heartView.removeFromSuperview()
            delegate?.updateHeartViews(heartViews)
        }
    }
}
