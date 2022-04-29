//
//  CharacterCellModelTests.swift
//  RickAndMortyTests
//
//  Created by Nazmi Yavuz on 29.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import XCTest
@testable import RickAndMorty
@testable import Apollo

class CharacterCellModelTests: XCTestCase {
    
    var result: GetCharactersQuery.Data.Character.Result?
    var sut: CharacterCellModel?

    func test_init() {
        // When
        sut = CharacterCellModel(characterId: "1",
                                 characterImageUrl: "https://www.image.com",
                                 characterName: "Rick Sanchez",
                                 characterLocation: "Citadel of Ricks")
        // Then
        XCTAssertEqual(sut?.characterId, "1")
        XCTAssertNotEqual(sut?.characterId, "2")
        XCTAssertEqual(sut?.characterImageUrl, "https://www.image.com")
        XCTAssertNotEqual(sut?.characterImageUrl, "https://www.image2.com")
        XCTAssertEqual(sut?.characterName, "Rick Sanchez")
        XCTAssertNotEqual(sut?.characterName, "Morty Smith")
        XCTAssertEqual(sut?.characterLocation, "Citadel of Ricks")
        XCTAssertNotEqual(sut?.characterLocation, "Earth (Replacement Dimension)")

    }
    
    func test_convenienceInit_notNilValue() {
        // Given
        let location = GetCharactersQuery.Data.Character.Result.Location(name: "Citadel of Ricks")
        
        result = GetCharactersQuery.Data.Character
            .Result(id: "2",
                    name: "Morty Smith",
                    image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                    location: location)
        // When
        sut = CharacterCellModel(character: result)
        // Then
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut?.characterId, result?.id)
        XCTAssertNotEqual(sut?.characterId, "3")
        XCTAssertEqual(sut?.characterImageUrl, result?.image)
        XCTAssertNotEqual(sut?.characterImageUrl, "https://www.image2.com")
        XCTAssertEqual(sut?.characterName, result?.name)
        XCTAssertNotEqual(sut?.characterName, "Rick Sanchez")
        XCTAssertEqual(sut?.characterLocation, location.name)
        XCTAssertNotEqual(sut?.characterLocation, "Earth (Replacement Dimension)")

    }
    
    func test_convenienceInit_nilValue() {
        // When
        sut = CharacterCellModel(character: result)
        // Then
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut?.characterId, "")
        XCTAssertNotEqual(sut?.characterId, "3")
        XCTAssertEqual(sut?.characterImageUrl, "")
        XCTAssertNotEqual(sut?.characterImageUrl, "https://www.image2.com")
        XCTAssertEqual(sut?.characterName, "")
        XCTAssertNotEqual(sut?.characterName, "Rick Sanchez")
        XCTAssertEqual(sut?.characterLocation, "")
        XCTAssertNotEqual(sut?.characterLocation, "Earth (Replacement Dimension)")

    }

}
