//
//  Alert.swift
//  TimezonesOfFriends-Coordinator
//
//  Created by Justyna Kowalkowska on 11/02/2021.
//

import UIKit

extension UIViewController {
    
    func createAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
