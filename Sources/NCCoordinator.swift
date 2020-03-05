//
// NCCoordinator.swift
// 
// Created by Alessio Sardella on 19/11/2018.
// Copyright 2019 Lepaya. All rights reserved.
//

import UIKit

open class NCCoordinator: Coordinator {
    
    public var navigationController: UINavigationController
    
    ///First view controller of the UINavigationController
    public var startController: EUIViewController!
    
    public init(rootController: EUIViewController) {
        self.navigationController = UINavigationController()
        self.navigationController.view.backgroundColor = .white
        self.navigationController.isNavigationBarHidden = true
        self.startController = rootController
        
    }
    
    ///Start the NCCordinator inside a TabCoordinator
    public func start() {
        
        if !self.navigationController.viewControllers.contains(startController){
            self.navigationController.pushViewController(startController, animated: true)
        }
        
    }
    
    ///Start the NCCordinator for navigation absed application
    public func start(window: UIWindow? = nil) {
        
        self.start()
        
        if let window = window {
            window.rootViewController = self.rootViewController
            window.makeKeyAndVisible()
            CoordinatorSession.shared.setNavCoordinator(self)
        }
    }
    
    ///Get the root UIViewController
    public var rootViewController: UIViewController {
        return self.navigationController
    }
    
    ///Check if the root UIViewController is visible
    public func rootViewControllerIsVisible() -> Bool {
        
        return self.startController == self.navigationController.currentViewController()
    }
    
}

extension UINavigationController {
    
    ///Get previous view controller of the navigation stack
    public func previousViewController() -> EUIViewController? {
        
        let lenght = self.viewControllers.count
        
        guard lenght >= 2, let previousViewController = self.viewControllers[lenght-2] as? EUIViewController else{
            return nil
        }
        
        return previousViewController
    }
    
    ///Get current view controller of the navigation stack
    public func currentViewController() -> EUIViewController? {
        
        let lenght = self.viewControllers.count
        
        guard lenght >= 1, let currentViewController = self.viewControllers[lenght-1] as? EUIViewController else{
            return nil
        }
        
        return currentViewController
    }
}
