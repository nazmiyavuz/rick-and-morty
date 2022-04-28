//
//  CharacterCellModel.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 28.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import Foundation

protocol CharacterCellDataSource: AnyObject {
    var characterId: Int { get }
    var characterImageUrl: String { get }
    var characterName: String { get }
    var characterLocation: String { get }
}

protocol CharacterCellEventSource: AnyObject {}

protocol CharacterCellProtocol: CharacterCellDataSource, CharacterCellEventSource {}

class CharacterCellModel: CharacterCellProtocol {
    
    var characterId: Int
    var characterImageUrl: String
    var characterName: String
    var characterLocation: String
    
    init(characterId: Int,
         characterImageUrl: String,
         characterName: String,
         characterLocation: String) {
        
        self.characterId = characterId
        self.characterImageUrl = characterImageUrl
        self.characterName = characterName
        self.characterLocation = characterLocation
    }
}
