//
//  UILabel+Extensions.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 28.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import UIKit

extension UILabel {
    
    func createAttribute(first: String,
                         firstFont: UIFont = Font.robotoRegular(size: 16).value,
                         firstColor: UIColor = .appLabel,
                         second: String,
                         secondFont: UIFont = Font.robotoBold(size: 16).value,
                         secondColor: UIColor = .appSecondaryLabel) {
        
        let firstAttributedText = NSMutableAttributedString(
            string: first,
            attributes: [
                .font: firstFont,
                .foregroundColor: firstColor
            ])
        
        let secondAttributedText = NSAttributedString(
            string: second,
            attributes: [
                .font: secondFont,
                .foregroundColor: secondColor
            ])

        firstAttributedText.append(secondAttributedText)
        self.attributedText = firstAttributedText
    }
}
