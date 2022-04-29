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
    func postNotification(with filter: FilterOption)
}

class FilterViewModel: BaseViewModel, FilterViewProtocol {
    
    var filter: FilterOption?
    
    init(navigator: MainNavigator, filter: FilterOption?) {
        self.filter = filter
        super.init(navigator: navigator)
    }
    
    // MARK: - Actions
    
    func postNotification(with filter: FilterOption) {
        let object: FilterOption? = filter == self.filter ? nil : filter
        let filterDict: [String: FilterOption?] = ["filter": object]
        NotificationCenter.default.post(
            name: .changeFilterOption, object: nil,
            userInfo: filterDict as [AnyHashable: Any])
    }
    
}
