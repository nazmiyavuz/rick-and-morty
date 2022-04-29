//
//  MockFilterViewModel.swift
//  RickAndMortyTests
//
//  Created by Nazmi Yavuz on 29.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import Foundation
@testable import RickAndMorty

final class MockFilterViewModel: FilterViewModel {
    
    private(set) var didSendNotification = false
    
    override func postNotification() {
        didSendNotification = true
    }
}
