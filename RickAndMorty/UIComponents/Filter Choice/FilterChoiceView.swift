//
//  FilterChoiceView.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 29.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import UIKit
import SnapKit

public class FilterChoiceView: UIView {
    
    enum ChoiceType: String {
        case filter
        case rick
        case morty
    }
    
    // MARK: - Views
    private let titleLabel: UILabel = {
        $0.textColor = .appLabel
        return $0
    }(UILabel())
    
    private let radioImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    private let separatorView: UIView = {
        $0.backgroundColor = .appSecondaryLabel
        return $0
    }(UIView())
    
    // MARK: - Properties
    
    var isSelected = false {
        willSet {
            switch newValue {
            case true:  radioImageView.image = .radioOnIcon
            case false: radioImageView.image = .radioOffIcon
            }
        }
    }
    
    private var choiceType: ChoiceType
    
    init(choiceType: ChoiceType) {
        self.choiceType = choiceType
        super.init(frame: .zero)
        self.setupConstraints()
        
    }
    // swiftlint:disable fatal_error unavailable_function
    required init?(coder: NSCoder) {
//        setupConstraints()
//        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    // swiftlint:enable fatal_error unavailable_function

    private func setupConstraints() {
        backgroundColor = .appSecondaryBackground
        let font: Font = choiceType == .filter ? .robotoBold(size: 24) : .robotoRegular(size: 24)
        titleLabel.font = font.value
        titleLabel.text = choiceType.rawValue.capitalized
        radioImageView.isHidden = choiceType == .filter
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
        }
        
        if choiceType == .filter {
            addSubview(separatorView)
            separatorView.snp.makeConstraints { make in
                make.leading.bottom.trailing.equalToSuperview()
                make.height.equalTo(1)
            }
        }
        
        guard choiceType != .filter else { return }
        
        let image: UIImage? = isSelected ? .radioOnIcon : .radioOffIcon
        radioImageView.image = image
        
        addSubview(radioImageView)
        radioImageView.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.top.trailing.equalToSuperview().inset(16)
        }
        
    }
}
