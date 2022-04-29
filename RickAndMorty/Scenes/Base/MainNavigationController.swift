//
//  MainNavigationController.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 28.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
    }
    
    private func configureContents() {
        
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.appLabel,
            NSAttributedString.Key.font: Font.robotoBold(size: 24).value
        ]
        
        navigationBar.barTintColor = .appPrimaryBackground
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = .appSecondaryLabel
        navigationBar.titleTextAttributes = titleTextAttributes

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = .clear
            appearance.backgroundColor = .appPrimaryBackground
            appearance.titleTextAttributes = titleTextAttributes
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance = appearance
        }
        
    }
    
}
