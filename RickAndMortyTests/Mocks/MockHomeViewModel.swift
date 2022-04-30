//
//  MockHomeViewModel.swift
//  RickAndMortyTests
//
//  Created by Nazmi Yavuz on 29.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import UIKit
@testable import RickAndMorty

final class MockHomeViewModel: HomeViewModel {
    
    private(set) var didGoToFilterScreen = false
    
    override func navigateToFilterScreen(fromVC: UIViewController) {
        didGoToFilterScreen = true
    }
    
}
