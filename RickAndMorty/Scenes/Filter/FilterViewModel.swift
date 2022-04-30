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
    
    var filter: FilterOption? { get set }
}

class FilterViewModel: BaseViewModel, FilterViewProtocol {
    
    var filter: FilterOption?
    
    init(navigator: MainNavigator, filter: FilterOption?) {
        super.init(navigator: navigator)
        self.filter = filter
        
    }
    
}
