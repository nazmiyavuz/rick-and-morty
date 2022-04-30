//
//  MainNavigator.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 27.04.2022.
//

import UIKit

/// to navigate the screens in an easy way
protocol MainNavigator: AnyObject {
    /// First screen which is at the beginning of the app
//    associatedtype StartScreen
    /// General destination which is a screen, you want to display
//    associatedtype Destination
    
    /**
    Start application in the beginning from StartScreen that is an associated type
     - parameters:
       - screen: StartScreen which is associated type
       - scene: UIScene for initialising
     */
    func start(with screen: StartScreen, scene: UIScene)
    
    /**
    Navigate to another screen that is named as Destination
     - parameters:
       - destination: Destination which is an associated type, navigate to related destination
     */
    func navigate(to destination: Destination)
    
}
