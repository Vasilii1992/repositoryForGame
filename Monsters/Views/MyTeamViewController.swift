

import Foundation
import UIKit
import Lottie


class MyTeamViewController: UIViewController {

    var capturedMonsters: [Monster] = []
    let backgroundImage: UIImageView = {
        let image = UIImageView(frame: UIScreen.main.bounds)
        image.image = UIImage(named: "myTeamBC")
        image.contentMode =  UIView.ContentMode.scaleAspectFill
        return image
    }()
    var animationView = LottieAnimationView()
    let notCaughtLabel = UILabel()
    let color = #colorLiteral(red: 0.8529672027, green: 0.6342731118, blue: 0.6172611713, alpha: 1)
    

    var tableView: UITableView = {
       let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: Resources.Identifiers.identifierForCell)
       return table
   }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Resources.MyTeamVC.myTeam
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let color = #colorLiteral(red: 0.005047614221, green: 0.1637888849, blue: 0.09214615077, alpha: 1)
        navigationController?.navigationBar.barTintColor = color
     //   navigationController?.navigationBar.alpha = 0.9

        animationView = .init(name: "movement")
        animationView.loopMode = .loop
        animationView.play()
        notCaughtLabel.createNewLabel(text: Resources.MyTeamVC.notCaught, color: color, size: 20)
        setupViews()
        setupTableView()
        setupConstraints()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .gray
        tableView.separatorInset = .zero
        tableView.reloadData()
    }
    
    private func setupViews() {
        tableView.backgroundView = backgroundImage
        view.addSubview(tableView)
        view.addSubview(notCaughtLabel)
        view.addSubview(animationView)

    }
    private func setupConstraints() {
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
      //  return capturedMonsters.count
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
            // чтобы не подсвечивал ячейку
            cell.selectionStyle = .none

            return cell
            
        }
}
