//
// TabCoordinator.swift
//
// Created by Alessio on 19/11/2018.
// Copyright 2019 Lepaya. All rights reserved.
//

import UIKit

public protocol TabCoordinatorDelegate: AnyObject {
    
    /**
     Use this method to reload the root EUIViewControllers on UITabBarController
     
     - Parameter controller: The controller to reload
     - Parameter index: The UITabBarController tab index
     
     */
    func reloadRootController(_ controller:EUIViewController, atIndex index: Int)
    
}

open class TabCoordinator: Coordinator {
    
    let window: UIWindow
    public let tabController: UITabBarController
    var tabNames: [String] = []
    var tabImages: [String] = []
    
    ///Select the first tab to load, default is 0.  Only the first visible tab's EUIViewController is loaded, the other are loaded only if the user select them.
    public var firstTabToLoad: Int = 0
    public var navigationCoordinators: [NCCoordinator] = []
    public weak var delegate: TabCoordinatorDelegate?
    
    public init(window: UIWindow, tabController: UITabBarController = UITabBarController()) {

        self.window = window
        self.tabController = tabController
        
    }
    
    /**
     Setup the UITabBarController.
     
     - Parameter tabNames: Names for the different tabs
     - Parameter tabImages: Images for the different tabs
     - Parameter coordinators: The NCCoordinators for each tab
     
     Example usage:
     ```
     let appCoordinator = TabCoordinator(window: self.window!)
     appCoordinator.setup(tabNames: ["first", "second"],
     tabImages: ["tab_image_01", "tab_image_02"]) { () -> ([NCCoordinator]) in
     
     let firstTab = NCCoordinator(rootController: RedController())
     
     let secondTab = NCCoordinator(rootController: GreenController())
     
     return [firstTab, secondTab]
     
     }
     appCoordinator.firstTabToLoad = 1
     appCoordinator.start()
     ```
     - important: Make sure to have the same number of `tabNames` and `tabImages`
     */
    public func setup(tabNames: [String], tabImages: [String], coordinators: () -> ([NCCoordinator])){
        
        print("Set Session's tabCoordinator")
        CoordinatorSession.shared.setTabCoordinator(self)
        self.tabNames = tabNames
        self.tabImages = tabImages
        self.navigationCoordinators = coordinators()
    }
    
    public func start() {
        
        var controllers: [UIViewController] = []
        
        var currentTabIndex: Int = 0
        for ncc in self.navigationCoordinators {
            
            let viewController = ncc.rootViewController
            viewController.tabBarItem = UITabBarItem(title: self.tabNames[currentTabIndex],
                                                     image: UIImage(named: self.tabImages[currentTabIndex]) ?? UIImage(),
                                                     tag: currentTabIndex)
            controllers.append(viewController)
            if self.firstTabToLoad == currentTabIndex {
                ncc.start()
            }
            currentTabIndex += 1
        }
        
        tabController.viewControllers = controllers
        tabController.selectedIndex = self.firstTabToLoad
        self.window.rootViewController = tabController
        self.window.makeKeyAndVisible()
    }
    
    ///Get current navigation controller in the selected tab
    public func currentNavigationController() -> UINavigationController? {
        
        return self.navigationCoordinators[self.tabController.selectedIndex].navigationController
        
    }
    
    ///Reload a selected tab, if the NCCoordinator is not started yet, it starts.
    public func reload(selectedIndex index: Int) {
        
        let coordinator = self.navigationCoordinators[index]
        
        if coordinator.startController.isViewLoaded {
            if coordinator.rootViewControllerIsVisible() {
                
                if let currentController = coordinator.startController {
                    
                    self.delegate?.reloadRootController(currentController, atIndex: index)
                    
                }
            }
            
        } else {
            
            coordinator.start()
            
        }
    }
}
