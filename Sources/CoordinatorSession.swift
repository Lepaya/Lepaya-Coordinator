//
// CoordinatorSession.swift
// 
// Created by Alessio Sardella on 08/05/2019.
// Copyright 2019 Lepaya. All rights reserved.
//

import Foundation

final public class CoordinatorSession {
    
    public static let shared = CoordinatorSession()
    public var tabCoordinator: TabCoordinator?
    public var navCoordinator: NCCoordinator?
    
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
}
