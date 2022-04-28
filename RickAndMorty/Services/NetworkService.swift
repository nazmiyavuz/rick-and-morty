//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 27.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import Foundation

// FIXME: Delete after fetching data from remote server
enum NetworkError: Error {
    case unKnown
}
// FIXME: Delete after fetching data from remote server
typealias CharacterResult = ((Result<[CartoonCharacter], NetworkError>) -> Void)

protocol NetworkServiceProtocol {
    func fetchCharacters(isSuccess: Bool, completion: @escaping CharacterResult)
}

class NetworkService: NetworkServiceProtocol {
    
    func fetchCharacters(isSuccess: Bool, completion: @escaping CharacterResult) {
        if isSuccess {
            let characterList = createMockCartoonCharacter()
            completion(.success(characterList))
        } else {
            completion(.failure(NetworkError.unKnown))
        }
        
    }
    
}

// TODO: Delete before merge
extension NetworkService {
    
    private func createMockCartoonCharacter() -> [CartoonCharacter] {
        return (1...20).map { charID -> CartoonCharacter in
            let name = charID % 2 == 0 ? "Morty" : "Rick"
            let location =  charID % 2 == 0 ? "Izmir" : "Istanbul"
            let imageUrl = "https://rickandmortyapi.com/api/character/avatar/\(charID).jpeg"
            return CartoonCharacter(id: charID, imageURL: imageUrl, name: name, location: location)
        }
        
    }
}
