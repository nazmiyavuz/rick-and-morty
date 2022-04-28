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
    var didSuccessFetchCharacters: VoidClosure? { get set }
}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {
    func fetchCharacters()
    func fetchMoreCharacters()
}

// MARK: - View Model

final class HomeViewModel: BaseViewModel, HomeViewProtocol {
    
    var isPagingEnabled = false
    
    var page = 1
    var cellItems: [CharacterCellProtocol] = []
  
    var didSuccessFetchCharacters: VoidClosure?
    
    var title: String?
    
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
                let cellItems = characters.map({ CharacterCellModel(character: $0) })
                self.cellItems.append(contentsOf: cellItems)
                self.page += 1
                // FIXME: change after fetching data from remote server
                self.isPagingEnabled = 1 < 10
                self.didSuccessFetchCharacters?()
                
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
}
