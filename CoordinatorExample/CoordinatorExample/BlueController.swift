//
//  BlueController.swift
//  CoordinatorExample
//
//  Created by Alessio Sardella on 05/07/2019.
//  Copyright © 2019 Alessio Sardella. All rights reserved.
//

import UIKit
import Lepaya_Coordinator

class BlueController: EUIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        self.setTabBarControllerDelegate()
        
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

extension BlueController: TabCoordinatorDelegate{
    func reloadRootController(_ controller: EUIViewController, atIndex index: Int) {
        
        if controller == self{
            
            UIView.animate(withDuration: 0.5) {
                self.view.backgroundColor = .black
            }
            
        }
    }
}
