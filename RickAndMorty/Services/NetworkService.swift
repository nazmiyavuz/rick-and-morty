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

final class NetworkService: NetworkServiceProtocol {
    
    private var urlString: String
    
    // "https://rickandmortyapi.com/graphql"
    lazy var apollo = ApolloClient(url: URL(string: urlString)!)
    
    init(_ url: String = "https://rickandmortyapi.com/graphql") {
        
        self.urlString = url
        
//        if let urlString = url {
//            self.urlString = urlString
//        } else {
//            self.urlString = "https://rickandmortyapi.com/graphql"
//        }
        
    }
    
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
        
    }
    
}
