

import UIKit

extension MyTeamViewController {
    
    func setupConstraints() {
       tableView.translatesAutoresizingMaskIntoConstraints = false
       
       notCaughtLabel.translatesAutoresizingMaskIntoConstraints = false
       animationView.translatesAutoresizingMaskIntoConstraints = false

         NSLayoutConstraint.activate([
             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             tableView.topAnchor.constraint(equalTo: view.topAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             
             notCaughtLabel.heightAnchor.constraint(equalToConstant: 148),
             notCaughtLabel.widthAnchor.constraint(equalToConstant: 344),
             notCaughtLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             notCaughtLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -350),
             
             animationView.heightAnchor.constraint(equalToConstant: 500),
             animationView.widthAnchor.constraint(equalToConstant: 500),
             animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             animationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10)
         ])
     }
}

extension MyTeamViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if capturedMonsters.isEmpty {
            return 0
                } else {
                    animationView.alpha = 0.0
                    notCaughtLabel.alpha = 0.0
                    return capturedMonsters.count
                }
    }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Identifiers.identifierForCell, for: indexPath) as! CustomTableViewCell
            let monster = capturedMonsters[indexPath.row]
            cell.configure(with: UIImage(named: monster.imageName), title: monster.name, subtitle: monster.subtitle)
            cell.titleLabel.textColor = .white
            cell.subtitleLabel.textColor = .white
            cell.backgroundColor = .clear
            cell.selectionStyle = .none

            return cell
            
        }
}
