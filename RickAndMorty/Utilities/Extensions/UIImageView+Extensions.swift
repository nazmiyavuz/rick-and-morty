//
//  UIImageView+Extensions.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 28.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import Kingfisher

public extension UIImageView {
    
    static let fadeAnimation = KingfisherOptionsInfoItem.transition(.fade(0.2))
    
    func setImage(_ string: String?, placeholder: UIImage? = nil) {
        self.kf.indicatorType = .activity
        let url = URL(string: string ?? "")
        self.kf.setImage(with: url, placeholder: placeholder,
                         options: [UIImageView.fadeAnimation])
    }
}
