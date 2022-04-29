//
//  Alert.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 28.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import UIKit

class Alert {
    
    static let main = Alert()
    
    private init() {}
    
    func showAlert(_ title: String?, message: String?) {
        let alert = UIAlertController(
            title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        if let window = UIApplication.firstKeyWindow {
            if var controller = window.rootViewController {
                while let newController = controller.presentedViewController {
                    controller = newController
                }
                DispatchQueue.main.async {
                    controller.present(alert, animated: true)
                }
            }
        }
    }
    
    func showErrorAlert(_ message: String) {
        showAlert("Ooops!", message: message)
    }
}
