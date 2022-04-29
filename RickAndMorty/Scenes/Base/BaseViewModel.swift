//
//  BaseViewModel.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 27.04.2022.
//  Copyright © 2022 Nazmi Yavuz. All rights reserved.
//

import Foundation

protocol BaseViewModelDataSource: AnyObject {}

protocol BaseViewModelEventSource: AnyObject {
    var showActivityIndicatorView: VoidClosure? { get set }
    var hideActivityIndicatorView: VoidClosure? { get set }
    
    var showLoading: VoidClosure? { get set }
    var hideLoading: VoidClosure? { get set }
    
    var showWarningAlert: StringClosure? { get set }
}

protocol BaseViewModelProtocol: BaseViewModelDataSource, BaseViewModelEventSource {}

// MARK: - ViewModel
class BaseViewModel: BaseViewModelProtocol {
    
    var showActivityIndicatorView: VoidClosure?
    var hideActivityIndicatorView: VoidClosure?
    
    var showLoading: VoidClosure?
    var hideLoading: VoidClosure?
    
    var showWarningAlert: StringClosure?
    
    internal let navigator: AppNavigator
    let networkService: NetworkServiceProtocol
    
    init(navigator: AppNavigator, networkService: NetworkServiceProtocol = NetworkService()) {
        self.navigator = navigator
        self.networkService = networkService
    }
    
}
