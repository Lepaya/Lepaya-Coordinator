//
// VCCoordinator.swift
// 
// Created by Alessio Sardella on 19/11/2018.
// Copyright 2019 Alessio Sardella. All rights reserved.
//

import UIKit

open class VCCoordinator: Coordinator {
    
    public weak var navigationController: UINavigationController!
    private weak var presented: EUIViewController!
    public weak var presenter: EUIViewController?
    
    ///Set the value of animated transition to 'false' if you don't want animation. Default value is true.
    public var animatedTransition: Bool = true
    
    /// Init method to push a new controller on the navigation stack
    public init(push presented: EUIViewController, presenter: UINavigationController) {
        
        self.presented = presented
        self.navigationController = presenter
        
    }
    
    ///Init method to present a modal controller
    public init(presentModally presented: EUIViewController, navigation: UINavigationController, presenter: EUIViewController) {
        
        self.presented = presented
        self.presenter = presenter
        self.navigationController = navigation
        
    }
    
    public func start() {
        if presenter == nil {
            self.navigationController.pushViewController(self.presented, animated: animatedTransition)
            
        } else {
            self.presented.isModal = true
            self.presenter?.present(presented, animated: animatedTransition, completion: nil)
        }
    }
    
    public func goback() {
        if presenter == nil {
            navigationController.popViewController(animated: animatedTransition)
        } else {
            self.presented.dismiss(animated: animatedTransition, completion: nil)
        }
    }
}
