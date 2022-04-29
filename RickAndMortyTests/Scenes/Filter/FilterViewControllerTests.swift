//
//  FilterViewControllerTests.swift
//  RickAndMortyTests
//
//  Created by Nazmi Yavuz on 29.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import XCTest
@testable import RickAndMorty

class FilterViewControllerTests: XCTestCase {

//    override func setUpWithError() throws {
//    }
//
//    override func tearDownWithError() throws {
//    }

    private func makeSut(with items: [CharacterCellModel]) -> FilterViewController {
        let mockAppNavigator = MockAppNavigator()
        let viewModel = MockFilterViewModel(navigator: mockAppNavigator, filter: nil)
        let sut = FilterViewController(viewModel: viewModel)
        _ = sut.view
        return sut
    }
}
