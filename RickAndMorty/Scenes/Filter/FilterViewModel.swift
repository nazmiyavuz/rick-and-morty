//
//  FilterViewModel.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 29.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import Foundation

protocol FilterViewDataSource {}

protocol FilterViewEventSource {}

protocol FilterViewProtocol: FilterViewDataSource, FilterViewEventSource {
    func postNotification()
}

class FilterViewModel: BaseViewModel, FilterViewProtocol {
    
    var filter: FilterOption?
    
    init(navigator: MainNavigator, filter: FilterOption?) {
        self.filter = filter
        super.init(navigator: navigator)
    }
    
    // MARK: - Actions
    
    func postNotification() {
        //
    }
    
}


