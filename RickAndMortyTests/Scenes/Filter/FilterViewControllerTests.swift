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
    
    func test_viewDidLoad_filterShouldBeNil() {
        XCTAssertNil(makeSut(filter: nil).viewModel.filter)
    }
    
    func test_viewDidLoad_filterShouldBeRick() {
        XCTAssertNotNil(makeSut(filter: .rick).viewModel.filter)
        XCTAssertEqual(makeSut(filter: .rick).viewModel.filter, .rick)
        XCTAssertNotEqual(makeSut(filter: .rick).viewModel.filter, .morty)
    }
    
    func test_viewDidLoad_filterShouldBeMorty() {
        XCTAssertNotNil(makeSut(filter: .rick).viewModel.filter)
        XCTAssertEqual(makeSut(filter: .morty).viewModel.filter, .morty)
        XCTAssertNotEqual(makeSut(filter: .morty).viewModel.filter, .rick)
    }
    
    func test_cancelButtonTapped() {
        // Given
        let mockAppNavigator = MockAppNavigator()
        let viewModel = FilterViewModel(navigator: mockAppNavigator, filter: nil)
        let viewController = MockFilterViewController(viewModel: viewModel)
        // When
        viewController.cancelButton.sendActions(for: .touchUpInside)
        // Then
        XCTAssertTrue(viewController.dismissCalled)
    }
    
    func test_rickButtonPressed() {

        let mockAppNavigator = MockAppNavigator()
        let viewModel = FilterViewModel(navigator: mockAppNavigator, filter: nil)
        let sut = MockFilterViewController(viewModel: viewModel)
        _ = sut.view

        sut.rickButton.sendActions(for: .touchUpInside)

        XCTAssertNotNil(sut.filterOption)
        XCTAssertEqual(sut.filterOption, .rick)
        XCTAssertNotEqual(sut.filterOption, .morty)

    }
    
    func test_mortyButtonPressed() {
        // Given
        let mockAppNavigator = MockAppNavigator()
        let viewModel = FilterViewModel(navigator: mockAppNavigator, filter: nil)
        let sut = MockFilterViewController(viewModel: viewModel)
        _ = sut.view
        // When
        sut.mortyButton.sendActions(for: .touchUpInside)
        // Then
        XCTAssertNotNil(sut.filterOption)
        XCTAssertEqual(sut.filterOption, .morty)
        XCTAssertNotEqual(sut.filterOption, .rick)
    }
    
    // MARK: - Helper

    private func makeSut(filter: FilterOption?) -> FilterViewController {
        let mockAppNavigator = MockAppNavigator()
        let viewModel = FilterViewModel(navigator: mockAppNavigator, filter: filter)
        let sut = FilterViewController(viewModel: viewModel)
        _ = sut.view
        return sut
    }
    
}
