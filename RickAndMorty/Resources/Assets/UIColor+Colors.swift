//
//  UIColor+Colors.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 28.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let appPrimaryBackground: UIColor = .init(named: "appPrimaryBackground") ?? "#E5E5E5".hexStringConvertToUIColor()
    
    static let appSecondaryBackground: UIColor = .init(named: "appSecondaryBackground") ?? "#FFFFFF".hexStringConvertToUIColor()
    
    static let appLabel: UIColor = .init(named: "appLabel") ?? "#000000".hexStringConvertToUIColor()
    
    static let appSecondaryLabel: UIColor = .init(named: "appSecondaryLabel") ?? "#C4C4C4".hexStringConvertToUIColor()
    
}
