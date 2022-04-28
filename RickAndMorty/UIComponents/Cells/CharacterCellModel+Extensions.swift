//
//  CharacterCellModel+Extensions.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 28.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import Foundation

extension CharacterCellModel {
    
    convenience init(character: CartoonCharacter) {
        
        self.init(
            characterId: character.id,
            characterImageUrl: character.imageURL,
            characterName: character.name,
            characterLocation: character.location)
    }
}
