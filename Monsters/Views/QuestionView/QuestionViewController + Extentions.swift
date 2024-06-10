

import UIKit

extension QuestionViewController {
    
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
    
}
