//
//  HomeViewModelTests.swift
//  RickAndMortyTests
//
//  Created by Nazmi Yavuz on 29.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import XCTest
@testable import RickAndMorty

class HomeViewModelTests: XCTestCase {

    var sut: HomeViewModel!
    var mockAppNavigator: MockAppNavigator!
    
    override func setUpWithError() throws {
        mockAppNavigator = MockAppNavigator()
        sut = HomeViewModel(navigator: mockAppNavigator)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        mockAppNavigator = nil
        sut = nil
        try super.tearDownWithError()
    }

    func test_init() {
        // Then
        XCTAssertFalse(sut.isPagingEnabled)
        XCTAssertTrue(sut.isFirstLoading)
        XCTAssertEqual(sut.page, 1)
        XCTAssertNil(sut.filter)
        XCTAssertNil(sut.numberOfPages)
        XCTAssertEqual(sut.cellItems.count, 0)
        XCTAssertEqual(sut.cellItems.count, sut.numberOfItems)
        XCTAssertNil(sut.didSuccessFetchCharacters)

    }
    
    func test_willSetOfFilter_shouldChangeOtherProperties() {
        // When
        let isFirstLoading = false
        sut.isFirstLoading = isFirstLoading
        sut.page = 3
        sut.filter = .rick
        // Then
        XCTAssertTrue(sut.isFirstLoading, "isFirstLoading should have been change to true.")
        XCTAssertNotEqual(sut.isFirstLoading, isFirstLoading, "isFirstLoading should have been change to true.")
        XCTAssertEqual(sut.page, 1, "page should have been change to 1.")
        XCTAssertNotEqual(sut.page, 3, "page should have been change to 1.")
    }
    
    func test_navigateToFilterScreen_shouldGoToFilterScreen() {
        // When
        sut.navigateToFilterScreen()
        // Then
        XCTAssertTrue(mockAppNavigator.didGoToDestination)
        
    }
    
    func test_cellItemForIndexPath_shouldReturnACharacterCellProtocol() {
        // Given
        let characterCellModel = CharacterCellModel(character: nil)
        // When
        sut.cellItems.append(characterCellModel)
        let item = sut.cellItem(for: [0, 0])
        // Then
        XCTAssertEqual(sut.cellItems.count, 1)
        XCTAssertNotNil(sut.cellItems.first)
        XCTAssertEqual(item.characterId, "")
        XCTAssertEqual(item.characterName, "")
        XCTAssertEqual(item.characterImageUrl, "")
        XCTAssertEqual(item.characterLocation, "")

    }
    
}
