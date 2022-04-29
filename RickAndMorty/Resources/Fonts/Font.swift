//
//  Font.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 28.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import UIKit

/// - Tag: Font
enum Font {
    
    case robotoRegular(size: CGFloat)
    
    case robotoBold(size: CGFloat)
    
    var value: UIFont {
        switch self {
            
        case .robotoRegular(size: let size):
            return UIFont(name: "Roboto-Regular", size: size) ?? .systemFont(ofSize: size, weight: .regular)
            
        case .robotoBold(size: let size):
            return UIFont(name: "Roboto-Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
        }
    }
}
