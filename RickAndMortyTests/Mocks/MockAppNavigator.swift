//
//  MockAppNavigator.swift
//  RickAndMortyTests
//
//  Created by Nazmi Yavuz on 29.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import UIKit
@testable import RickAndMorty

class MockAppNavigator: MainNavigator {
    
    private(set) var didStartTheApp = false
    private(set) var didGoToDestination = false
    
    func start(with screen: StartScreen, scene: UIScene) {
        didStartTheApp = true
    }
    
    func navigate(to destination: Destination) {
        didGoToDestination = true
    }
}
