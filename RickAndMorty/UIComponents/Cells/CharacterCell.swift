//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 28.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell, ReusableView {
    
    // MARK: - UIViews
    
    private let cardView: UIView = {
        $0.backgroundColor = .systemBackground
        $0.cornerRadius = 20
        return $0
    }(UIView())
    
    private let characterImageView: UIImageView = {
        $0.image = .mockCellImage
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    private let idLabel: UILabel = {
        $0.createAttribute(first: "#ID: ", second: "1")
        return $0
    }(UILabel())
    
    private let nameLabel: UILabel = {
        $0.createAttribute(first: "Name: ", second: "Rick Shancez")
        return $0
    }(UILabel())
    
    private let locationLabel: UILabel = {
        $0.createAttribute(first: "Location: ", second: "Earth")
        return $0
    }(UILabel())
    
    // MARK: - ViewModel
    weak var viewModel: CharacterCellProtocol?
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.characterImageView.image = nil
        self.idLabel.attributedText = nil
        self.nameLabel.attributedText = nil
        self.locationLabel.attributedText = nil
    }
}

// MARK: - UILayout
extension CharacterCell {
    
    private func addSubViews() {
        backgroundColor = .systemBackground
        
    }
}

// MARK: - Set ViewModel
extension CharacterCell {
    
    func set(with viewModel: CharacterCellProtocol) {
        self.viewModel = viewModel
        
    }
}
