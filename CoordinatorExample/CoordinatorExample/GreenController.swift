//
//  GreenController.swift
//  CoordinatorExample
//
//  Created by Alessio Sardella on 05/07/2019.
//  Copyright © 2019 Alessio Sardella. All rights reserved.
//

import UIKit
import CoordinatorPackage

class GreenController: EUIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .green
        self.setTabBarControllerDelegate()
        
        CoordinatorSession.shared.tabCoordinator?.delegate = self
        
    }
    
    func loadButtonBack(){
        
        let button = UIButton(frame: self.view.bounds)
        button.backgroundColor = .clear
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.goBack), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
}

extension GreenController: TabCoordinatorDelegate{
    func reloadRootController(_ controller: EUIViewController, atIndex index: Int) {
        
        if controller == self{
            self.view.backgroundColor = .yellow
        }
    }
}
