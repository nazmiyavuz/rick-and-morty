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
                         firstFont: UIFont = .systemFont(ofSize: 16, weight: .medium),
                         firstColor: UIColor = .label,
                         second: String,
                         secondFont: UIFont = .systemFont(ofSize: 16, weight: .regular),
                         secondColor: UIColor = .secondaryLabel) {
        
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
