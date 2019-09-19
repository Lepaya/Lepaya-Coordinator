//
//  RedController.swift
//  CoordinatorExample
//
//  Created by Alessio Sardella on 05/07/2019.
//  Copyright © 2019 Alessio Sardella. All rights reserved.
//

import UIKit
import Lepaya_Coordinator

class RedController: EUIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        self.setTabBarControllerDelegate()
        
        let button = UIButton(frame: self.view.bounds)
        button.backgroundColor = .clear
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.pushNext), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc func pushNext(){
        self.getNavigationController { (navigation) in
            
            let green = GreenController()
            green.loadButtonBack()
            let coordinator = VCCoordinator(presentModally: green, navigation: navigation, presenter: self)
            green.coordinator = coordinator
            coordinator.start()
        }
    }
}
