//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 28.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import UIKit
import SnapKit

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
        $0.textAlignment = .right
        return $0
    }(UILabel())
    
    private let nameLabel: UILabel = {
        $0.createAttribute(first: "Name: ", second: "Rick Shancez")
        return $0
    }(UILabel())
    
    private let locationLabel: UILabel = {
        $0.createAttribute(first: "Location: ", second: "Earth")
        $0.numberOfLines = 0
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
        addCardView()
        addCharacterImageView()
        addIdLabel()
        addNameLabel()
        addLocationLabel()
    }
    
    private func addCardView() {
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.bottom.equalToSuperview().inset(8)
        }
    }
    
    private func addCharacterImageView() {
        cardView.addSubview(characterImageView)
        characterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(168)
        }
    }
    
    private func addIdLabel() {
        cardView.addSubview(idLabel)
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImageView).offset(8)
            make.trailing.equalToSuperview().inset(14)
        }
    }
    
    private func addNameLabel() {
        cardView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(idLabel).offset(8)
            make.leading.trailing.equalToSuperview().inset(14)
        }
    }
    
    private func addLocationLabel() {
        cardView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel).offset(8)
            make.leading.trailing.equalTo(nameLabel)
        }
    }
}

// MARK: - Set ViewModel
extension CharacterCell {
    
    func set(with viewModel: CharacterCellProtocol) {
        self.viewModel = viewModel
        
    }
}
