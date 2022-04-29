//
//  HomeViewModel.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 28.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import Foundation

// MARK: - Protocol

protocol HomeViewDataSource {
    var numberOfItems: Int { get }
    
    func cellItem(for indexPath: IndexPath) -> CharacterCellProtocol
}

protocol HomeViewEventSource {
    var didSuccessFetchCharacters: AppendCellClosure? { get set }
}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {
    func navigateToFilterScreen()
    func fetchCharacters()
    func fetchMoreCharacters()
}

// MARK: - View Model

class HomeViewModel: BaseViewModel, HomeViewProtocol {
    
    var isPagingEnabled = false
    
    var isFirstLoading = true
    var page = 1
    
    var filter: FilterOption? {
        willSet {
            page = 1
            isFirstLoading = true
        }
    }
    var numberOfPages: Int?
    var cellItems: [CharacterCellProtocol] = []
  
    var didSuccessFetchCharacters: AppendCellClosure?
    
    var numberOfItems: Int {
        return cellItems.count
    }
    
    func navigateToFilterScreen() {
        navigator.navigate(to: .filter(filter))
    }
    
    func cellItem(for indexPath: IndexPath) -> CharacterCellProtocol {
        let item = cellItems[indexPath.row]
        return item
    }
    
    // MARK: - Network
    
    func fetchCharacters() {
        
        networkService.fetchCharacters(page: page, filter: filter) { [weak self] (result: Result<GetCharactersQuery.Data.Character, NetworkError>) in
            
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            switch result {
            case .success(let charactersData):
                
                let firstIndex = self.cellItems.count
                self.numberOfPages = charactersData.info?.pages
                
                guard let characters = charactersData.results else {
                    self.showWarningAlert?("Something wrong. Please try again later.")
                    return
                }
                
                let cellItems = characters.map({ CharacterCellModel(character: $0) })
                let lastIndex = cellItems.count + firstIndex - 1
                
                let indexPathList = self.createIndexPathList(firstIndex: firstIndex, lastIndex: lastIndex)
                
                if self.isFirstLoading {
                    self.cellItems.removeAll(keepingCapacity: false)
                    self.cellItems = cellItems
                } else {
                    self.cellItems.append(contentsOf: cellItems)
                }
                
                self.page += 1
                
                self.isPagingEnabled = self.page < self.numberOfPages ?? 1
                
                self.didSuccessFetchCharacters?(self.isFirstLoading, indexPathList)
                
            case .failure(let error):
                Logger.error("getting \(error.localizedDescription)")
                if self.page == 1 {
                    self.showWarningAlert?("\(error.localizedDescription) Something wrong. Please try again later.")
                    
                }
            }
        }
    }
  
    func fetchMoreCharacters() {
        fetchCharacters()
    }
    // There are only one section which is 0
    private func createIndexPathList(firstIndex: Int, lastIndex: Int) -> [IndexPath] {
        Array(firstIndex...lastIndex).map { IndexPath(row: $0, section: 0) }
    }
}
