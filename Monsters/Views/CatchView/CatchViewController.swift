

import UIKit
import MapKit
import CoreGraphics
import Lottie

final class CatchViewController: UIViewController, CatchManagerDelegate {

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
        label.font = UIFont(name: "Marker Felt", size: 35)
        label.textColor = color
        label.sizeToFit()
        return label
    }()

    private var catchManager: CatchManager!

    init(monster: Monster, heartViews: [LottieAnimationView]) {
        self.monster = monster
        self.heartViews = heartViews
        super.init(nibName: nil, bundle: nil)
        self.catchManager = CatchManager(monster: monster, heartViews: heartViews)
        self.catchManager.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage()
        addActionToButton()
        imageViewForAnimation.alpha = 0.0

        buttonStile()
        setupImageView()
        setupViews()
        setupConstraints()

        heartConstrains()
    }

    func backgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: monster.backgraund)
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        view.addSubview(backgroundImage)
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
        catchManager.buttonTappedForCatch(imageView: imageView, monsterNameLabel: monsterNameLabel, caughtLabel: caughtLabel, notCaughtLabel: notCaughtLabel, animationView: imageViewForAnimation)
            updateHeartViews(HeartManager.shared.heartViews)
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

    func setupViews() {
        view.addSubview(monsterNameLabel)
        view.addSubview(imageView)
        view.addSubview(imageViewForAnimation)
        view.addSubview(catchButton)
    }

    func updateHeartViews(_ heartViews: [LottieAnimationView]) {
        self.heartViews = heartViews
        
        HeartManager.shared.heartViews = heartViews
        HeartManager.shared.heartCount = heartViews.count
    }

    func showCaughtLabel(_ label: UILabel) {
        view.addSubview(label)
        UIView.animate(withDuration: 1.0, animations: {
            label.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 3.0, animations: {
                label.alpha = 0.0
                self.imageView.alpha = 0.0
            }) { _ in
                label.removeFromSuperview()
            }
        }
    }

    func showNotCaughtLabel(_ label: UILabel) {
        view.addSubview(label)
        UIView.animate(withDuration: 1.0, animations: {
            label.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 3.0, animations: {
                label.alpha = 0.0
            }) { _ in
                label.removeFromSuperview()
            }
        }
    }

    func animateImageView(_ imageView: UIImageView, with animationView: LottieAnimationView) {
        UIView.animate(withDuration: 2.0, animations: {
            animationView.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 2.0, animations: {
                animationView.alpha = 0.0
            }) { _ in
                animationView.removeFromSuperview()
            }
        }
    }

    func didCaptureMonster(_ monster: Monster) {
        delegate?.didCaptureMonster(monster)
        catchButton.setTitle(Resources.Strings.backToMap, for: .normal)
        catchButton.removeTarget(self, action: #selector(buttonTappedForCatch), for: .touchUpInside)
        catchButton.addTarget(self, action: #selector(returnToMapButtonTapped), for: .touchUpInside)
    }

    func didEscapeMonster(_ monster: Monster) {
        delegate?.didEscapeMonster(monster)
        catchButton.setTitle(Resources.Strings.backToMap, for: .normal)
        catchButton.removeTarget(self, action: #selector(buttonTappedForCatch), for: .touchUpInside)
        catchButton.addTarget(self, action: #selector(returnToMapButtonTapped), for: .touchUpInside)
    }
}
