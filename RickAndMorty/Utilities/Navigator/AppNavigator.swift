//
//  AppNavigator.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 27.04.2022.
//

import UIKit

final class AppNavigator: MainNavigator {
    
    enum StartScreen {
        case home
    }
    
    enum Destination {
        case filter
    }
    
    static let shared = AppNavigator()
        
    private var window: UIWindow?
    
    private var navigationController: UINavigationController?
    
    // MARK: Initialiser
    private init() {
        self.window?.backgroundColor = .white
    }
    
    // MARK: - Start
    func start(with screen: StartScreen, scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else {
            Logger.error("getting windowScene"); return
        }
        window = UIWindow(windowScene: windowScene)
        switch screen {
        case .home:
            let viewModel = HomeViewModel(navigator: self)
            let viewController = HomeViewController(viewModel: viewModel)
            let navigationController = UINavigationController(rootViewController: viewController)
            self.navigationController = navigationController
        }
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = self.navigationController
        window?.makeKeyAndVisible()
    }
    
    // MARK: - Navigate
    func navigate(to destination: Destination) {
        switch destination {
            
        case .filter:
            
            let viewController = HomeViewController(viewModel: HomeViewModel(navigator: self))
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
