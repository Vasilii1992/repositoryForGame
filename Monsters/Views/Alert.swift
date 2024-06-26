
import UIKit

final class Alert  {

    static func showAlert(viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: Resources.Alert.settings, style: .default) { alert in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
        let cancelAction = UIAlertAction(title: Resources.Alert.cancel, style: .cancel,handler: nil)
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        viewController.present(alert,animated: true,completion: nil)
    }
}

