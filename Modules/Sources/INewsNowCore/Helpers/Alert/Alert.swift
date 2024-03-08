//
//  Alert.swift
//  INewsNow
//
//  Created by Pedro Henrique on 06/03/24.
//

import UIKit

public final class Alert {
    
   public static func showBasicAlert(title: String, message: String, viewController: UIViewController, completion: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    public static func showActionSheet(title: String, message: String, viewController: UIViewController, onCompletion: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let tryAgainAction = UIAlertAction(title: "Tente outra vez", style: .default) { _ in
            alertController.dismiss(animated: true)
            onCompletion(true)
        }
        alertController.addAction(tryAgainAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { _ in
            onCompletion(false)
        }
        alertController.addAction(cancelAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
