//
//  CharacterCellModel+Extensions.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 28.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import Foundation

extension CharacterCellModel {
    
    convenience init(character: GetCharactersQuery.Data.Character.Result?) {
        
        self.init(
            characterId: character?.id ?? "",
            characterImageUrl: character?.image ?? "",
            characterName: character?.name ?? "",
            characterLocation: character?.location?.name ?? "")
    }
}
