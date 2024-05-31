

import UIKit

final class QuestionViewController: UIViewController {
    
    let instructionLabel: UILabel = {
        let color = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        let label = UILabel(frame: CGRect(x: 10, y: 100, width: 300, height: 100))
        label.createNewLabel(text: Resources.Strings.instructionLabel0, color: color, size: 18)
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 150, y: 750, width: 100, height: 50))
        button.MyOwnButtonStile(setTitle: Resources.Strings.questionButtonNext, fontSize: 20)
        return button
    }()
    
    let clickButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 130, y: 850, width: 250, height: 40))
        button.MyOwnButtonStile(setTitle: Resources.Strings.privacyPolicy, fontSize: 15)
        return button
    }()
    
    var nextButtonTapCount = 0
    var instructionLabelTopConstraint: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "questionBackgraund2")
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        
        view.backgroundColor = .white
        view.addSubview(instructionLabel)
        view.addSubview(nextButton)
        view.addSubview(clickButton)
        
        setupConstraints()
        addButtonAction()
    }
    
    func setupConstraints() {
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        clickButton.translatesAutoresizingMaskIntoConstraints = false
        
        instructionLabelTopConstraint = instructionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)

        
        NSLayoutConstraint.activate([
            instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructionLabelTopConstraint,
            instructionLabel.widthAnchor.constraint(equalToConstant: 300),
            instructionLabel.heightAnchor.constraint(equalToConstant: 100),
            
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -135),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            clickButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
            clickButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -65),
            clickButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clickButton.widthAnchor.constraint(equalToConstant: 250),
            clickButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func addButtonAction() {
        clickButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc func buttonClicked() {
        if let url = URL(string: "http://project8422592.tilda.ws") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func returnToMapButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func nextButtonTapped() {
        nextButtonTapCount += 1
        
        switch nextButtonTapCount {
        case 1:
            updateInstructionLabel(text: Resources.Strings.instructionLabel, topConstant: 180)
        case 2:
            updateInstructionLabel(text: Resources.Strings.instructionLabel2, topConstant: 290)
        case 3:
            updateInstructionLabel(text: Resources.Strings.instructionLabel3, topConstant: 410)
        case 4:
            updateInstructionLabel(text: Resources.Strings.instructionLabel4, topConstant: 150)
        case 5:
            updateInstructionLabel(text: Resources.Strings.instructionLabel5, topConstant: view.bounds.height / 2 - 50)
            self.nextButton.setTitle(Resources.Strings.questionButtonBack, for: .normal)
            self.nextButton.removeTarget(self, action: #selector(self.nextButtonTapped), for: .touchUpInside)
            self.nextButton.addTarget(self, action: #selector(self.returnToMapButtonTapped), for: .touchUpInside)
        default:
            break
        }
    }
    
    func updateInstructionLabel(text: String, topConstant: CGFloat) {
        instructionLabel.text = text
        instructionLabelTopConstraint.isActive = false
        instructionLabelTopConstraint = instructionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant)
        instructionLabelTopConstraint.isActive = true
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
}
