//
// CoordinatorSession.swift
// 
// Created by Alessio Sardella on 08/05/2019.
// Copyright 2019 Lepaya. All rights reserved.
//

import Foundation

final public class CoordinatorSession {
    
    public static let shared = CoordinatorSession()
    public private(set) var tabCoordinator: TabCoordinator?
    public private(set) var navCoordinator: NCCoordinator?
    
    /**
     Get the current CoordinatorSession visible controller. If there is no controller returns nil.
     */
    final public func visibleController() -> ExtendedViewController?{
        
        if let tabs = self.tabCoordinator {
            
            return tabs.currentNavigationController()?.currentViewController()
            
        } else if let nav = self.navCoordinator {
            
            return nav.navigationController.currentViewController()
            
        } else{
            
            return nil
        }
    }
    
    final public func setTabCoordinator(_ tab: TabCoordinator){
        self.tabCoordinator = tab
        self.navCoordinator = nil
    }
    
    final public func setNavCoordinator(_ nav: NCCoordinator){
        self.navCoordinator = nav
        self.tabCoordinator = nil
    }
}
