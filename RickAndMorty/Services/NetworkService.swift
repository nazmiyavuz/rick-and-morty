//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 27.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import Foundation
import Apollo

enum NetworkError: Error {
    case unKnown
    case known(String)
}

typealias CharacterResult = ((Result<GetCharactersQuery.Data.Character, NetworkError>) -> Void)

protocol NetworkServiceProtocol {
    func fetchCharacters(page: Int, filter: FilterOption?, completion: @escaping CharacterResult)
}

enum FilterOption: String {
    case rick
    case morty
}

class NetworkService: NetworkServiceProtocol {
    
    private lazy var apollo = ApolloClient(url: URL(string: "https://rickandmortyapi.com/graphql")!)
    
    func fetchCharacters(page: Int, filter: FilterOption?, completion: @escaping CharacterResult) {
        
        apollo.fetch(query: GetCharactersQuery(name: filter?.rawValue, page: page)) { result in
            switch result {
                
            case .success(let graphQLResult):
                guard let data = graphQLResult.data?.characters else {
                    completion(.failure(NetworkError.unKnown)); return
                }
                completion(.success(data))
            case .failure(let error):
                completion(.failure(NetworkError.known(error.localizedDescription)))
            }
        }
        
//        if isSuccess {
//            let characterList = createMockCartoonCharacter()
//            completion(.success(characterList))
//        } else {
//            completion(.failure(NetworkError.unKnown))
//        }
        
    }
    
}

// TODO: Delete before merge
extension NetworkService {
    
    private func createMockCartoonCharacter() -> [CartoonCharacter] {
        return (1...20).map { charID -> CartoonCharacter in
            let name = charID % 2 == 0 ? "Morty" : "Rick"
            let location = charID % 2 == 0 ? "Izmir" : "Istanbul"
            let imageUrl = "https://rickandmortyapi.com/api/character/avatar/\(charID).jpeg"
            return CartoonCharacter(id: charID, imageURL: imageUrl, name: name, location: location)
        }
        
    }
}
