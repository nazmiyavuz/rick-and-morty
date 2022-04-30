//
//  MockFilterViewController.swift
//  RickAndMortyTests
//
//  Created by Nazmi Yavuz on 30.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import UIKit
@testable import RickAndMorty

class MockFilterViewController: FilterViewController {
    
    private(set) var dismissCalled = false
    private(set) var filterOption: FilterOption?

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.dismissCalled = true
    }
    
    override func didTapChoiceButton(_ button: UIButton) {
        let pressedFilter = FilterOption(tag: button.tag)
        filterOption = pressedFilter
    }
}
