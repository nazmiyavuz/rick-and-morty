//
//  UIApplication+Extensions.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 27.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import UIKit

extension UIApplication {
    
    static var firstKeyWindow: UIWindow? {
        
        UIApplication.shared
            // Of all connected scenes...
            .connectedScenes.lazy

            // ... grab all foreground active window scenes ...
            .compactMap { $0.activationState == .foregroundActive ? ($0 as? UIWindowScene) : nil }

            // ... finding the first one which has a key window ...
            .first(where: { $0.keyWindow != nil })?

            // ... and return that window.
            .keyWindow
    }
}
