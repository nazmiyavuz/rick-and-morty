//
//  MockHomeViewModel.swift
//  RickAndMortyTests
//
//  Created by Nazmi Yavuz on 29.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import Foundation
@testable import RickAndMorty

final class MockHomeViewModel: HomeViewModel {
    
    private(set) var didGoToFilterScreen = false
    
    override func navigateToFilterScreen() {
        didGoToFilterScreen = true
    }
    
    override func fetchCharacters() {
        //
    }
    
    override func fetchMoreCharacters() {
        fetchCharacters()
    }
}
