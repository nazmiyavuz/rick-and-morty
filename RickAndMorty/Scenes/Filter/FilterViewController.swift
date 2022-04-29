//
//  FilterViewController.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 29.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import UIKit
import SnapKit

final class FilterViewController: BaseViewController<FilterViewModel> {
    
    // MARK: - Views
    
    private lazy var cancelButton: UIButton = {
        $0.backgroundColor = .black.withAlphaComponent(0.7)
        $0.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    private lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.cornerRadius = 10
        return $0
    }(UIStackView())
    
    lazy var rickChoiceView = FilterChoiceView(choiceType: .rick)
    lazy var mortyChoiceView = FilterChoiceView(choiceType: .morty)
    
    lazy var rickButton = UIButton(type: .system)
    lazy var mortyButton = UIButton(type: .system)
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
    }
    
}
// MARK: - UILayout
extension FilterViewController {
    
    private func addSubViews() {
        view.backgroundColor = .clear
        addCancelButton()
        addStackView()
        addChoiceButtons()
    }
    
    private func addCancelButton() {
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    private func addStackView() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.width.equalTo(327)
            make.centerX.centerY.equalToSuperview()
        }
        let sectionView = FilterChoiceView(choiceType: .filter)
        stackView.addArrangedSubview(sectionView)
        stackView.addArrangedSubview(rickChoiceView)
        stackView.addArrangedSubview(mortyChoiceView)
        
    }
    
    private func addChoiceButtons() {
        // Rick
        rickChoiceView.addSubview(rickButton)
        rickButton.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        rickButton.addTarget(self, action: #selector(didTapChoiceButton), for: .touchUpInside)
        // Morty
        mortyChoiceView.addSubview(mortyButton)
        mortyButton.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        mortyButton.addTarget(self, action: #selector(didTapChoiceButton), for: .touchUpInside)
        mortyButton.tag = 1

    }
}

// MARK: - Actions
extension FilterViewController {
    
    @objc
    private func cancelButtonTapped() {
        print("DEBUG: did tapped button..")
        self.dismiss(animated: true)
    }
    
    @objc
    private func didTapChoiceButton(_ button: UIButton) {
        Logger.debug("DEBUG: did tapped button. Button.tag: \(button.tag)")
    }
    
}
