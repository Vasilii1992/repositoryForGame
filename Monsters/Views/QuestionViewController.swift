//
//  QuestionViewController.swift
//  Monsters
//
//  Created by Василий Тихонов on 19.05.2023.
//

import UIKit


class QuestionViewController: UIViewController {
    

    let instructionLabel0: UILabel = {
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
    
    let instructionLabel: UILabel = {
        let color = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)

        let label = UILabel(frame: CGRect(x: 90, y: 180, width: 300, height: 100))
        label.createNewLabel(text: Resources.Strings.instructionLabel, color: color, size: 18)
        label.isHidden = true
        
        return label
    }()
    
    let instructionLabel2: UILabel = {
        let color = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)

        let label = UILabel(frame: CGRect(x: 10, y: 300, width: 300, height: 100))

        label.createNewLabel(text: Resources.Strings.instructionLabel2, color: color, size: 18)
        label.isHidden = true
        
        return label
    }()
    
    let instructionLabel3: UILabel = {
        let color = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)

        let label = UILabel(frame: CGRect(x: 90, y: 370, width: 300, height: 100))

        label.createNewLabel(text: Resources.Strings.instructionLabel3, color: color, size: 18)
        label.isHidden = true
        
        return label
    }()
    
    let instructionLabel4: UILabel = {
        let color = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)

        let label = UILabel(frame: CGRect(x: 10, y: 510, width: 300, height: 100))

        label.createNewLabel(text: Resources.Strings.instructionLabel4, color: color, size: 18)
        label.isHidden = true
        
        return label
    }()
    
    let instructionLabel5: UILabel = {
        let color = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)

        let label = UILabel()
        label.createNewLabel(text: Resources.Strings.instructionLabel5, color: color, size: 18)
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
        view.addSubview(instructionLabel0)
        view.addSubview(nextButton)
        view.addSubview(clickButton)
        view.addSubview(instructionLabel)
        view.addSubview(instructionLabel2)
        view.addSubview(instructionLabel3)
        view.addSubview(instructionLabel4)
        view.addSubview(instructionLabel5)
        
      //  setupConstrains()
        setupConstraints()
        addButtonAction()
        
        
    }
    
    
    
    
    func setupConstraints() {
        instructionLabel0.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel2.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel3.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel4.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel5.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        clickButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -135).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        clickButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        clickButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -65).isActive = true
        clickButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        clickButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        clickButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        

        instructionLabel0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        instructionLabel0.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        instructionLabel0.widthAnchor.constraint(equalToConstant: 300).isActive = true
        instructionLabel0.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        instructionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 180).isActive = true
        instructionLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        instructionLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        instructionLabel2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        instructionLabel2.topAnchor.constraint(equalTo: view.topAnchor, constant: 290).isActive = true
        instructionLabel2.widthAnchor.constraint(equalToConstant: 300).isActive = true
        instructionLabel2.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        instructionLabel3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        instructionLabel3.topAnchor.constraint(equalTo: view.topAnchor, constant: 410).isActive = true
        instructionLabel3.widthAnchor.constraint(equalToConstant: 300).isActive = true
        instructionLabel3.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        instructionLabel4.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        instructionLabel4.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        instructionLabel4.widthAnchor.constraint(equalToConstant: 300).isActive = true
        instructionLabel4.heightAnchor.constraint(equalToConstant: 100).isActive = true

        instructionLabel5.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        instructionLabel5.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        instructionLabel5.widthAnchor.constraint(equalToConstant: 300).isActive = true
        instructionLabel5.heightAnchor.constraint(equalToConstant: 100).isActive = true
      }
    
    
    
    
    
    
    @objc func buttonClicked() {
           // Open the URL when the button is clicked
           if let url = URL(string: "http://project8422592.tilda.ws") {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
           }
       }
    
    func addButtonAction() {
        
        
        
        clickButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
//    func setupConstrains() {
//        instructionLabel5.translatesAutoresizingMaskIntoConstraints = false
//        instructionLabel5.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        instructionLabel5.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//    }
    
    @objc func returnToMapButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func nextButtonTapped() {
        nextButtonTapCount += 1
        
        if nextButtonTapCount == 1 {
            UIView.animate(withDuration: 1.0, animations: {
                self.instructionLabel0.alpha = 0
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
            self.nextButton.setTitle(Resources.Strings.questionButtonBack, for: .normal)
                            self.nextButton.removeTarget(self, action: #selector(self.nextButtonTapped), for: .touchUpInside)
                            self.nextButton.addTarget(self, action: #selector(self.returnToMapButtonTapped), for: .touchUpInside)
        } else {
           
        }
        
    }
    
    
    
}

