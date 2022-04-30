//
//  HomeViewControllerTests.swift
//  RickAndMortyTests
//
//  Created by Nazmi Yavuz on 29.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import XCTest
@testable import RickAndMorty

class HomeViewControllerTests: XCTestCase {
    
    var mockAppNavigator: MockAppNavigator!
    var mockHomeViewModel: MockHomeViewModel!

    override func setUpWithError() throws {
        mockAppNavigator = MockAppNavigator()
        mockHomeViewModel = MockHomeViewModel(navigator: mockAppNavigator)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        mockAppNavigator = nil
        mockHomeViewModel = nil
        try super.tearDownWithError()
    }
    
    func test_homeViewControllerTitle() {
        // Then
        XCTAssertEqual(makeSut(with: []).navigationItem.title, "Rick and Morty")
    }
    
    func test_filterBarButtonImage() {
        // Given
        let image = makeSut(with: []).navigationItem.rightBarButtonItem?.image
        // Then
        XCTAssertEqual(image, .filterIcon)
    }
    
    func test_filterButtonTapped_shouldGoFilterScreen() {
        // Given
        let sut = makeSut(with: [])
        let action = sut.navigationItem.rightBarButtonItem?.action
        // When
        sut.perform(action)
        // Then
        XCTAssertTrue(mockHomeViewModel.didGoToFilterScreen)
    }
    
    func test_tableView_numberOfCell_shouldEqualToZero() {
        XCTAssertEqual(makeSut(with: []).tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_tableView_numberOfCell_shouldEqualToTwenty() {
        // Then
        XCTAssertEqual(makeSut(with: createMockCartoonCharacter()).tableView.numberOfRows(inSection: 0), 20)
    }
    
    func test_tableView_withFirstCell_isEqualTo() {
        // Given
        let sut = makeSut(with: createMockCartoonCharacter())
        sut.tableView.reloadData()
        // When
        let cell = sut.tableView.cellForRow(at: [0, 0]) as? CharacterCell
        // Then
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.idLabel.attributedText?.string, "#id: 1")
        XCTAssertEqual(cell?.nameLabel.attributedText?.string, "Name: Rick")
        XCTAssertEqual(cell?.locationLabel.attributedText?.string, "Location: Istanbul")
    }
    
    func test_tableView_didSelectRowAt_isEqualTo() {
        // Given
        let sut = makeSut(with: createMockCartoonCharacter())
        sut.tableView.reloadData()
        let tableView = sut.tableView
        // When
        sut.tableView(tableView, didSelectRowAt: [0, 0])
        let willBeSelected = sut.tableView(tableView, cellForRowAt: [0, 0])
        // Then
        XCTAssertNotNil(willBeSelected)
    }
    
    // MARK: - Helpers
    
    private func createMockCartoonCharacter() -> [CharacterCellModel] {
        return (1...20).map { charID -> CartoonCharacter in
            let name = charID % 2 == 0 ? "Morty" : "Rick"
            let location = charID % 2 == 0 ? "Izmir" : "Istanbul"
            let imageUrl = "https://rickandmortyapi.com/api/character/avatar/\(charID).jpeg"
            return CartoonCharacter(id: charID, imageURL: imageUrl, name: name, location: location)
        }.map { (item) -> CharacterCellModel in
            CharacterCellModel(characterId: "\(item.id)", characterImageUrl: item.imageURL,
                               characterName: item.name, characterLocation: item.location)
        }
    }
    
    private func makeSut(with items: [CharacterCellModel]) -> HomeViewController {
        mockHomeViewModel.cellItems = items
        let sut = HomeViewController(viewModel: mockHomeViewModel)
        _ = sut.view
        return sut
    }
    
}
