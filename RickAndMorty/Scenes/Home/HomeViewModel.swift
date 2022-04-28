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

final class HomeViewModel: BaseViewModel, HomeViewProtocol {
    
    func navigateToFilterScreen() {
        Logger.debug("FilterButtonTapped")
//        navigator.navigate(to: .filter)
    }
    
    var isPagingEnabled = false
    
    var page = 1
    var cellItems: [CharacterCellProtocol] = []
  
    var didSuccessFetchCharacters: AppendCellClosure?
    
    var numberOfItems: Int {
        return cellItems.count
    }
    
    func cellItem(for indexPath: IndexPath) -> CharacterCellProtocol {
        let item = cellItems[indexPath.row]
        return item
    }
}

// MARK: - Network
extension HomeViewModel {
    
    func fetchCharacters() {
        
        networkService.fetchCharacters(isSuccess: true) { [weak self] (result: Result<[CartoonCharacter], NetworkError>) in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            switch result {
            case .success(let characters):
                let firstIndex = self.cellItems.count
                
                let cellItems = characters.map({ CharacterCellModel(character: $0) })
                let lastIndex = cellItems.count + firstIndex - 1
                
                let indexPathList = self.createIndexPathList(firstIndex: firstIndex, lastIndex: lastIndex)
                
                self.cellItems.append(contentsOf: cellItems)
                self.page += 1
                // FIXME: change after fetching data from remote server
                self.isPagingEnabled = 1 < 10
                self.didSuccessFetchCharacters?(self.page != 1, indexPathList)
                
            case .failure(let error):
                if self.page == 1 {
                    self.showWarningAlert?("\(error.localizedDescription) Lütfen ekranı yukarıdan aşağıya kaydırarak yenileyiniz.")
                    
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
