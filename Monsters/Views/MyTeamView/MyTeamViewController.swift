

import UIKit
import Lottie


final class MyTeamViewController: UIViewController {

    var capturedMonsters: [Monster] = []
    let backgroundImage: UIImageView = {
        let image = UIImageView(frame: UIScreen.main.bounds)
        image.image = UIImage(named: Resources.ImageForDisplay.myTeamBC)
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

        animationView = .init(name: Resources.LottieAnimationView.movement)
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
}
