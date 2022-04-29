//
//  NetworkServiceIntegrationTests.swift
//  RickAndMortyIntegrationTests
//
//  Created by Nazmi Yavuz on 29.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import XCTest
@testable import RickAndMorty

class NetworkServiceIntegrationTests: XCTestCase {

    func test_graphQLRemoteData_shouldReturnsCharacters() {
        // Given
        let expectation = self.expectation(description: "GraphQL Web Service Response Expectation")
        let sut = makeSut("https://rickandmortyapi.com/graphql")
        // When
        sut.fetchCharacters(page: 1, filter: nil) { (result) in
            guard let data = try? result.get() else {
                XCTFail("Getting nil value")
                expectation.fulfill()
                return
            }
            
            let results = data.results?.compactMap { $0 }
            guard let characters = results else {
                XCTFail("Getting nil value")
                expectation.fulfill()
                return
            }
            // Then
            XCTAssertNotNil(data)
            XCTAssertEqual(characters.count, 20)
            XCTAssertNotEqual(characters.count, 2)
            XCTAssertEqual(data.info?.count, 826)
            XCTAssertEqual(data.info?.pages, 42)
            XCTAssertEqual(characters.first?.id, "1")
            XCTAssertEqual(characters.first?.name, "Rick Sanchez")
            XCTAssertEqual(characters.first?.image, "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
            XCTAssertEqual(characters.first?.location?.name, "Citadel of Ricks")
            XCTAssertNotEqual(characters.first?.id, "2")
            XCTAssertNotEqual(characters.first?.name, "Rick")
            XCTAssertNotEqual(characters.first?.image, "")
            XCTAssertNotEqual(characters.first?.location?.name, "")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }
    
    func test_graphQLRemoteData_shouldReturnsFilteredCharacters() {
        // Given
        let expectation = self.expectation(description: "GraphQL Web Service Response Expectation")
        let sut = makeSut("https://rickandmortyapi.com/graphql")
        // When
        sut.fetchCharacters(page: 1, filter: .morty) { (result) in
            guard let data = try? result.get() else {
                XCTFail("Getting nil value")
                expectation.fulfill()
                return
            }
            
            let results = data.results?.compactMap { $0 }
            guard let characters = results else {
                XCTFail("Getting nil value")
                expectation.fulfill()
                return
            }
            // Then
            XCTAssertNotNil(data)
            XCTAssertEqual(characters.count, 20)
            XCTAssertNotEqual(characters.count, 2)
            XCTAssertEqual(data.info?.count, 68)
            XCTAssertEqual(data.info?.pages, 4)
            XCTAssertEqual(characters.first?.id, "2")
            XCTAssertEqual(characters.first?.name, "Morty Smith")
            XCTAssertEqual(characters.first?.image, "https://rickandmortyapi.com/api/character/avatar/2.jpeg")
            XCTAssertEqual(characters.first?.location?.name, "Citadel of Ricks")
            XCTAssertNotEqual(characters.first?.id, "1")
            XCTAssertNotEqual(characters.first?.name, "Rick")
            XCTAssertNotEqual(characters.first?.image, "")
            XCTAssertNotEqual(characters.first?.location?.name, "")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }
    
    func test_graphQLRemoteData_shouldReturnsNilCharacters() {
        // Given
        let expectation = self.expectation(description: "GraphQL Web Service Response Expectation")
        // When
        makeSut("https://rickandmortyapi.com/graphq").fetchCharacters(page: 1, filter: nil) { (result) in
            let data = try? result.get()
            // Then
            XCTAssertNil(data)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }
    
    func test_graphQLRemoteData_shouldThrowsError() {
        // Given
        let expectation = self.expectation(description: "GraphQL Web Service Response Expectation")
        // When
        makeSut("https://rickandmortyapi.com/graphq").fetchCharacters(page: 1, filter: nil) { (result) in
            do {
                _ = try result.get()
                XCTFail("Data should have been nil")
                expectation.fulfill()
            } catch {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        self.wait(for: [expectation], timeout: 2)
    }
    
    // MARK: - Helper
    
    private func makeSut(_ url: String) -> NetworkService { NetworkService(url) }

}
