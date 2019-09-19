//
// ExtendedViewController.swift
// 
// Created by Alessio Sardella on 09/04/2019.
// Copyright 2019 Alessio Sardella. All rights reserved.
//

import UIKit

public typealias EUIViewController = ExtendedViewController

///ExtendedViewController is the basic UIViewController
open class ExtendedViewController: UIViewController {
    
    public var isModal: Bool = false
    public var coordinator: VCCoordinator?
    public var tabsController: UITabBarController? {
        
        return CoordinatorSession.shared.tabCoordinator?.tabController
        
    }
    
    public func setTabBarControllerDelegate(){
        print("TABS: \(String(describing: self.tabsController))")
        self.tabsController?.delegate = self
        print("TABS DELEGATE: \(String(describing: self.tabsController?.delegate))")
        
    }
    
    
    @objc public final func goBack(){
        
        self.coordinator?.goback()
        
    }
}

extension EUIViewController: UITabBarControllerDelegate {
    /*
     UITabBarControllerDelegate, automatically reload the first view controller of each tab if it is visible when the tab is selected from the user.
     */
    
    public final func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        CoordinatorSession.shared.tabCoordinator?.reload(selectedIndex: tabBarController.selectedIndex)
        
    }
}

extension EUIViewController {
    
    /**
     Return in the completion block the UINavigationController of the ExtendedViewController, if exist, otherwise log an error on FireBase.
     
     - parameter completion: pass through the current navigation controller
     
     */
    final public func getNavigationController(completion: @escaping (UINavigationController) -> Void) {
        
        if let navigation = self.navigationController {
            
            DispatchQueue.main.async {
                
                completion(navigation)
                
            }
            
        } else {
            
            print("No navigation controller")
        }
    }
}
