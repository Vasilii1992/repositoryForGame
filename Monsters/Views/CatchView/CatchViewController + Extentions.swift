

import UIKit

extension CatchViewController {
    
    func setupConstraints() {

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
